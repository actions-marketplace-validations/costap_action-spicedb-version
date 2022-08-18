# SpiceDB GitHub Action

This project is a [GitHub Action] that outputs SpiceDB version for your workflows to use to upgrade version.

[GitHub Action]: https://github.com/features/actions

## Usage

Add the following any workflow:

```yaml
steps:
- uses: "costap/action-spicedb-version@v1"
  with:
    version: "latest"
```
