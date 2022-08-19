# Example

```
name: update

on:
  workflow_dispatch:
  schedule:
    - cron:  '0 8 */1 * *'
  push:
    branches:
      - 'main'

permissions:
  contents: write

jobs:
  spicedb:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          ref: main
      - name: Find Spicedb latest version
        id: get-spicedb
        uses: costap/action-spicedb-version@v0.2.0
        with:
          version: "latest"
      - name: Set the Spicedb version
        id: check
        env:
          SPICEDB_VERSION: ${{ steps.get-spicedb.outputs.version }}
        run: |
          echo "Found Spicedb version ${SPICEDB_VERSION}"
          yq eval '.images[0].newTag=env(SPICEDB_VERSION)' -i ./deployments/kustomize/base/spicedb/kustomization.yaml

          if [[ $(git diff --stat) != '' ]]; then
            echo ::set-output name=version::${SPICEDB_VERSION}
          fi
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v3
        if: steps.check.outputs.version
        with:
          token: ${{ secrets.GH_PAT }}
          committer: github-actions[bot] <github-actions[bot]@users.noreply.github.com>
          author: github-actions[bot] <github-actions[bot]@users.noreply.github.com>
          commit-message: Update SpiceDB to ${{ steps.check.outputs.version }}
          title: "chore: Update SpiceDB to ${{ steps.check.outputs.version }}"
          body: |
            SpiceDB v${{ steps.check.outputs.version }}
          branch: update-spicedb
```