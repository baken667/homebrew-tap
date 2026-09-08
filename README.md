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
2. `brew audit --online --except=style,version --formula baken667/tap/<name>`
3. `brew install --formula baken667/tap/<name> && brew test --formula baken667/tap/<name>`
4. Commit and open a PR.

Note the audit flags. `--new` is not used: it enforces homebrew-core
submission criteria (repository age, stars, forks) that a personal tap cannot
meet. `--except=style,version` is needed for GoReleaser-generated formulae,
which necessarily put `def install` inside per-platform blocks (rubocop
rejects defining a method in a block) and emit an explicit `version` field
(Homebrew calls it redundant with the one it can scan from the URL). Neither
is fixable here — the formula is regenerated on every release.

## Workflows

- `.github/workflows/audit.yml` — audits, installs and tests every formula on
  each PR and push to `main`, plus a weekly schedule. It no-ops while
  `Formula/` is empty. The job links the checkout into Homebrew's taps
  directory before running, because `brew` only accepts formula *names* and
  naming one requires its tap to exist — and tapping from GitHub would audit
  the published formula rather than the one a pull request proposes.

## License

MIT — see [LICENSE](LICENSE).
