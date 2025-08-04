class Pipedream < Formula
    desc "CLI utility for Pipedream"
    homepage "https://pipedream.com"

    def self.fetch_checksum(url)
      require "open-uri"
      URI.open("#{url}.sha256", &:read).strip
    rescue
      # Fallback to :no_check if checksum URL is unavailable
      :no_check
    end

    def base_url
      "https://cli.pipedream.com"
    end

    on_macos do
      artifact_url = "#{base_url}/darwin/amd64/latest/pd.zip"
      url artifact_url
      sha256 fetch_checksum(artifact_url)
    end

    on_linux do
      artifact_url = "#{base_url}/linux/amd64/latest/pd.zip"
      url artifact_url
      sha256 fetch_checksum(artifact_url)
    end

    # Automatically check for new versions
    livecheck do
      url "#{base_url}/LATEST_VERSION"
      regex(/^v?(\d+(?:\.\d+)+)$/i)
    end

    def install
      bin.install "pd"
    end  

    def caveats; <<~EOS
      ❤ Thanks for installing the Pipedream CLI! If this is your first time using the CLI, be sure to run `pd login` first.
    EOS
    end
  
    test do
      system "#{bin}/pd", "--version"
    end
end

