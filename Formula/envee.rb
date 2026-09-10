# Homebrew formula for envee, rendered by .github/workflows/release.yml on
# every tag and pushed to baken667/homebrew-tap (or -staging for pre-releases).
# Prebuilt archives per platform; nothing is compiled on the user's machine.
class Envee < Formula
  desc "Per-directory environment variable manager"
  homepage "https://github.com/baken667/envee"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.3/envee_0.4.3_darwin_arm64.tar.gz"
      sha256 "df6ca27bfbfa6eba6bc4f069ef4f74777d92e627dfbc4c48417ea5812e5b5b40"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.3/envee_0.4.3_darwin_amd64.tar.gz"
      sha256 "f757273794b3fea4f978205966248d384d311f9c35dab1ed6e33299b7061c8c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.3/envee_0.4.3_linux_arm64.tar.gz"
      sha256 "ada6ad52c7aac9ac1701877c3a0b217abcac62b245c5ac1752552ab045f5c4e9"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.3/envee_0.4.3_linux_amd64.tar.gz"
      sha256 "e671aff9e06db3eae9ff122a17f544dd66edbc246ef4876a77791c7a9608c770"
    end
  end

  def install
    bin.install "envee"
    bin.install "envee-plugin-env"
    bin.install "envee-plugin-infisical"
    generate_completions_from_executable(bin/"envee", "completion")
  end

  def caveats
    <<~EOS
      To enable envee in your shell, add one of these to your config:
        bash:  eval "$(envee init bash)"
        zsh:   eval "$(envee init zsh)"
        fish:  envee init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/envee --version")
    assert_match "_envee_hook", shell_output("#{bin}/envee init bash")
    assert_match "add-zsh-hook", shell_output("#{bin}/envee init zsh")
    assert_match "_envee_hook", shell_output("#{bin}/envee init fish")
    assert_match "\"name\":\"env\"", shell_output("#{bin}/envee-plugin-env metadata")
    assert_match "\"name\":\"infisical\"", shell_output("#{bin}/envee-plugin-infisical metadata")
  end
end
