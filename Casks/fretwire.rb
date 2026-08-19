cask "fretwire" do
  # Both lines are rewritten by scripts/release.sh in the app repository once a
  # release is published; the checksum is of the image attached to that tag.
  version "0.3.0"
  sha256 "e06ea2746c7728a4449d1cb29374db0d6eea9044f31185df6cf862830b591e20"

  url "https://github.com/olegklimakov/fretwire/releases/download/v#{version}/Fretwire-#{version}.dmg"
  name "Fretwire"
  desc "Native Git client built around the commit graph"
  homepage "https://github.com/olegklimakov/fretwire"

  # The feed the shipped app polls for its own updates doubles as the answer to
  # "what is the current version" — /releases/latest/ resolves to the newest
  # release, so this URL never has to be bumped.
  livecheck do
    url "https://github.com/olegklimakov/fretwire/releases/latest/download/appcast.xml"
    # Each appcast item carries both the marketing version and the build number
    # Sparkle actually compares. Taking only the former keeps this in the same
    # terms as `version` above, which would otherwise read as permanently
    # outdated against a "0.1.0,1" it can never equal.
    strategy :sparkle, &:short_version
  end

  # Fretwire updates itself through Sparkle. Without this, Homebrew would see
  # an app whose version no longer matches the cask and reinstall over a copy
  # that is already newer.
  auto_updates true
  # macOS 14 and up; `macos:` compares with >= unless told otherwise.
  depends_on macos: :sonoma

  app "Fretwire.app"

  # Host tokens live in the login Keychain under the service
  # "com.klimakov.fretwire.host" and deliberately stay there: `zap` removes
  # application state, and Homebrew has no business deleting credentials.
  zap trash: [
    "~/Library/Caches/com.klimakov.fretwire",
    "~/Library/HTTPStorages/com.klimakov.fretwire",
    "~/Library/Preferences/com.klimakov.fretwire.plist",
    "~/Library/Saved Application State/com.klimakov.fretwire.savedState",
  ]
end
