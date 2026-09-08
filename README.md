# homebrew-tap

Homebrew tap for [baken667](https://github.com/baken667) tools.

## Install

```bash
brew install baken667/tap/envee
```

`brew` expands `baken667/tap` to this repository, so there is no separate
`brew tap` step.

## Available formulae

| Formula | Description | Status |
|---|---|---|
| envee | [Per-directory environment variable manager](https://github.com/baken667/envee) | pre-1.0 |

`Formula/` is empty until the first release lands — see below.

## How this tap is updated

**Do not edit `Formula/*.rb` by hand.** GoReleaser regenerates each formula in
full and pushes it directly to `main` on every tagged release of the source
project. Anything you write there is overwritten without warning.

To change a formula, change the `brews:` block in the source project instead:

- [`baken667/envee/.goreleaser.yaml`](https://github.com/baken667/envee/blob/main/.goreleaser.yaml)

When a `v*` tag is pushed in `baken667/envee`:

1. GoReleaser cross-compiles `envee` and `enveed` for macOS and Linux
   (amd64 + arm64) and packs them into release archives.
2. It computes the SHA-256 of each archive.
3. It writes `Formula/envee.rb` here — pointing at the release download URLs,
   with per-platform checksums — and pushes it straight to `main` using a
   token stored as `HOMEBREW_TAP_TOKEN` in the source repository.
4. `main` must therefore have **no branch protection**: a rejected push
   happens after the GitHub release is already published, leaving a
   half-finished release.
5. Users get the new version with `brew update && brew upgrade envee`.

Formulae are binary formulae — Homebrew downloads the prebuilt archive rather
than compiling from source, so `depends_on "go"` is not needed.

Pre-releases (`v*-rc.N`, `-beta.N`, `-alpha.N`) go to
[`baken667/homebrew-tap-staging`](https://github.com/baken667/homebrew-tap-staging)
instead, so this tap only ever carries stable builds.

## Adding a new formula

For a project that releases through GoReleaser, add a `brews:` block pointing
at this repository — nothing needs to be committed here.

For a hand-written formula:

1. Create `Formula/<name>.rb`.
2. `brew audit --strict --online --formula Formula/<name>.rb`
3. `brew install --formula Formula/<name>.rb && brew test --formula Formula/<name>.rb`
4. Commit and open a PR.

Note that `brew audit --new` is not used here: it enforces homebrew-core
submission criteria (repository age, stars, forks) that a personal tap cannot
meet.

## Workflows

- `.github/workflows/audit.yml` — runs `brew audit --strict --online`, then
  installs and tests every formula, on each PR and push to `main` plus a
  weekly schedule. It no-ops while `Formula/` is empty.

## License

MIT — see [LICENSE](LICENSE).
