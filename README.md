# homebrew-tap

Homebrew tap for urugus CLI tools.

## Install

```sh
brew tap urugus/tap
brew install baseline
```

## Upgrade

```sh
brew update
brew upgrade baseline
```

## Release auto merge

Release PRs can be merged automatically when all of these checks pass:

- The PR is opened by `urugus` or `github-actions[bot]` from a same-repository branch named `codex/update-*`.
- Exactly one `Casks/*.rb` file is changed.
- Only one top-level `version` line and one top-level `sha256` line are changed.
- The cask release asset is hosted on GitHub and its downloaded SHA-256 matches the PR.
- Required CI checks pass.

Set `RELEASE_AUTOMERGE_TOKEN` to a repository secret for an admin token with repo access. The workflow uses that token only after the release PR validation and required CI checks pass.
