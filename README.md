# Homebrew tap for Fretwire

[Fretwire](https://github.com/olegklimakov/fretwire) is a native macOS Git
client built around the commit graph. This repository holds the Homebrew cask
that installs it.

```sh
brew install --cask olegklimakov/fretwire/fretwire
```

That taps this repository on the way past; nothing has to be tapped first.

Homebrew refuses to load a third-party tap by its short name unless you have
said you trust it, so `brew install --cask fretwire` will not work afterwards
until you do:

```sh
brew trust olegklimakov/fretwire
```

Spelling the full name out, as above, counts as trusting it for that one
command.

## Updating

Fretwire updates itself: the app checks the same release feed Homebrew reads
here and installs new versions in place, which is why the cask is marked
`auto_updates true`. `brew upgrade` therefore leaves it alone unless asked to
reconsider apps that update themselves:

```sh
brew upgrade --cask --greedy olegklimakov/fretwire/fretwire
```

Either route lands on the same build. The cask is bumped automatically when a
release is published, so it never lags behind the app's own update feed.

## Uninstalling

```sh
brew uninstall --cask --zap olegklimakov/fretwire/fretwire
```

`--zap` also removes preferences, caches and saved window state. Tokens for
GitHub and GitLab are stored in the login Keychain and are left alone — remove
them in Keychain Access if you want them gone.
