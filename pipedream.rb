class Pipedream < Formula
    desc "CLI utility for Pipedream"
    homepage "https://pipedream.com"

    def self.fetch_version
      require "open-uri"
      URI.open("https://cli.pipedream.com/LATEST_VERSION", &:read).strip
    rescue
      "latest"
    end

    def self.fetch_checksum(url)
      require "open-uri"
      URI.open("#{url}.sha256", &:read).strip
    rescue
      # Fallback to :no_check if checksum URL is unavailable
      :no_check
    end

    version fetch_version

    on_macos do
      url "https://cli.pipedream.com/darwin/amd64/latest/pd.zip"
      sha256 fetch_checksum("https://cli.pipedream.com/darwin/amd64/latest/pd.zip")
    end

    on_linux do
      url "https://cli.pipedream.com/linux/amd64/latest/pd.zip"
      sha256 fetch_checksum("https://cli.pipedream.com/linux/amd64/latest/pd.zip")
    end

    # Automatically check for new versions
    livecheck do
      url "https://cli.pipedream.com/LATEST_VERSION"
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

