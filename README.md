# homebrew-tap

Personal Homebrew tap for [baken](https://github.com/baken) tools.

## How to use

```bash
brew install baken/tap/envee
```

## Available formulae

| Formula | Description | Status |
|---|---|---|
| [envee](Formula/envee.rb) | Per-directory environment variable manager | stable |

## Adding a new formula

1. Create `Formula/<name>.rb`.
2. Validate locally: `brew audit --strict --new Formula/<name>.rb`.
3. Test install: `brew install --build-from-source Formula/<name>.rb`.
4. Commit and push.

## How this tap is updated

This tap is **automatically updated** by [GoReleaser](https://goreleaser.com) in
the [baken/envee](https://github.com/baken/envee) repository on every tagged release.

When a new `v*` tag is pushed:

1. GoReleaser builds `envee` and `enveed` for all supported OS/arch combos.
2. GoReleaser computes SHA256 checksums.
3. GoReleaser opens a PR here (or, for trusted workflows, auto-merges) with:
   - Updated `Formula/envee.rb` (new version + SHA256).
   - Updated bottles block (prebuilt binaries for fast install).
4. Users run `brew update && brew upgrade envee` and get the new version.

See [`baken/envee/.goreleaser.yaml`](../envee/.goreleaser.yaml) for the source of truth.

## Workflow files

- `.github/workflows/audit.yml` — runs `brew audit` and `brew test` on every PR to ensure formulae stay clean.

## License

MIT — see [LICENSE](../envee/LICENSE) in the parent project.
