# Apple NFC and App Clips — Proof of Concept

This SwiftUI proof of concept uses a physical NFC tag to identify a library book and open its details on an iPhone. The full iOS app and its App Clip share the same scanning and borrowing flow.

## Presentation materials

- [Video lesson and demo (GoogleDrive)](VideoLesson/AppClipAndCoreNFC.md)
- [Presentation slides (PDF)](Documentation/PoC-Presentation.pdf)

## How it works

1. Tap **Escanear livro** in the app or App Clip.
2. Hold the iPhone near an NFC tag containing an NDEF Text record with the value `LIVRO-001`.
3. The app looks up the tag in its local catalog and opens the matching book.
4. Tap **Solicitar empréstimo** to confirm the loan. The book stays marked as borrowed for the current session.

The prototype uses a bundled catalog and stores loan state in memory. The book tag is read after the app or App Clip is open. Launching an App Clip from a tag uses a separate invocation URL and requires an App Clip experience. [Apple's App Clip setup guide](https://developer.apple.com/documentation/appclip/configuring-the-launch-experience-of-your-app-clip)

## Run the demo

You’ll need a Mac with Xcode and the iOS 26 SDK or later, an NFC-capable iPhone running iOS 26 or later, and an NFC tag programmed with `LIVRO-001` as an NDEF Text record.

```sh
git clone https://github.com/PedroTeruel/PoC-Apple-NFC-AppClip.git
cd PoC-Apple-NFC-AppClip
open App/PoCNFCAppClip/PoCNFCAppClip.xcodeproj
```

1. Select your development team under **Signing & Capabilities** for both targets. If you change the bundle identifiers, use the full app’s bundle identifier as the prefix for the App Clip’s and update its parent application entitlement. [Apple's Xcode setup guide](https://developer.apple.com/documentation/appclip/creating-an-app-clip-with-xcode)
2. Select the `PoCNFCAppClip` scheme for the full app or `DefaultClip` for the App Clip.
3. Select your physical iPhone as the run destination and run the scheme from Xcode.
4. Tap **Escanear livro** and hold the iPhone near the programmed tag.

## Project layout

| Path | Purpose |
| --- | --- |
| [`App/PoCNFCAppClip/PoCNFCAppClip/`](App/PoCNFCAppClip/PoCNFCAppClip/) | Full iOS app, shared SwiftUI views, local book catalog, and Core NFC reader |
| [`App/PoCNFCAppClip/DefaultClip/`](App/PoCNFCAppClip/DefaultClip/) | App Clip entry point, assets, and entitlements |

The [`secondEx-SportsApp` branch](https://github.com/PedroTeruel/PoC-Apple-NFC-AppClip/tree/secondEx-SportsApp) explores a separate sports court reservation use case.
