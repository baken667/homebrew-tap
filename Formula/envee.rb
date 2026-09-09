# Homebrew formula for envee, rendered by .github/workflows/release.yml on
# every tag and pushed to baken667/homebrew-tap (or -staging for pre-releases).
# Prebuilt archives per platform; nothing is compiled on the user's machine.
class Envee < Formula
  desc "Per-directory environment variable manager"
  homepage "https://github.com/baken667/envee"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.2/envee_0.4.2_darwin_arm64.tar.gz"
      sha256 "a37ab1e273b069d29b2e358de85790922dc863003859727dc336059645525f1d"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.2/envee_0.4.2_darwin_amd64.tar.gz"
      sha256 "f96a149d7e049780784ff61aae5969098879f596ce843c5fd610ab8e66622578"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.2/envee_0.4.2_linux_arm64.tar.gz"
      sha256 "bd4267f191821b6c325d02623c202729d58ce17e3808b4de66ed50c73f66b5b4"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.2/envee_0.4.2_linux_amd64.tar.gz"
      sha256 "9ce3f92f1a0ce75b2783431dd526cb200bb4a7ed94ca800c8a18cb5500e59a99"
    end
  end

  def install
    bin.install "envee"
    bin.install "envee-plugin-env"
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
  end
end
