# Submitting Aligner Tracker to the App Store

The app is already wrapped as a native iOS project. What is left needs a Mac and an Apple
account, so it has to be done by you.

---

## What is already done

- Native iOS project (`ios/`) and Android project (`android/`), built with Capacitor.
- **Real iOS alarms.** In the native build the reminder is handed to iOS as a scheduled
  local notification, so it fires even when the app is force-quit — the one thing the web
  version could never do. The website keeps its Web Audio fallback; the same `index.html`
  detects which it is running as.
- Native haptics for the buzz.
- App icon (1024×1024, square and opaque, as Apple requires).
- Portrait lock, matching the layout.
- `ITSAppUsesNonExemptEncryption: false`, so App Store Connect stops asking about
  encryption on every upload.
- Privacy policy at `privacy.html`, live at
  https://yosefsmith82-blip.github.io/retainer_tracker_-/privacy.html

The app itself is unchanged — same screens, same data, same look.

---

## What you need

| | |
|---|---|
| A Mac | with Xcode from the Mac App Store. No Mac? [MacStadium](https://www.macstadium.com) or [MacinCloud](https://www.macincloud.com) rent one by the hour. |
| Apple Developer Program | about **$99/year**, at [developer.apple.com/programs](https://developer.apple.com/programs/) — confirm the current price. |
| CocoaPods | `sudo gem install cocoapods` |
| An iPhone | useful for testing the real build, not strictly required. |

---

## Build it

```bash
git clone https://github.com/yosefsmith82-blip/retainer_tracker_-.git
cd retainer_tracker_-
npm install
npm run ios          # builds www/, syncs it into the iOS project, opens Xcode
```

If `npm run ios` fails on CocoaPods, run `cd ios/App && pod install` once, then retry.
The `ios/` project in this repo was generated on Linux, so its Pods have never been
installed — that step happens on your Mac.

In Xcode:

1. Select the **App** target → **Signing & Capabilities**.
2. Set **Team** to your Apple developer account. Xcode handles the certificates.
3. The bundle identifier is `com.yossismith.alignertracker`. Change it if you prefer —
   it must be unique across the App Store, and it can never be changed after your first
   upload. Update `capacitor.config.json` to match.
4. Press ▶ with your iPhone connected to try it on the device.

Whenever you change the app, run `npm run sync` to copy the web files into the native
project before rebuilding.

---

## Submit it

1. **App Store Connect** → [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   → My Apps → **+** → New App. Pick the bundle id from step 3 above.
2. In Xcode: **Product → Archive**, then **Distribute App → App Store Connect**.
3. Fill in the listing:
   - **Screenshots** — required for 6.7" and 6.5" iPhones. Take them on a simulator
     (⌘S in the Simulator saves one).
   - **Description**, **keywords**, **support URL** (the GitHub repo works),
     **privacy policy URL** (the link above).
   - **Age rating** — answer the questionnaire; this app is 4+.
   - **App Privacy** — answer **"Data Not Collected"**. That is accurate: nothing leaves
     the phone.
   - **Category** — Health & Fitness, or Medical.
4. Submit for review. First reviews usually take a day or two.

---

## Things that get apps like this rejected

**Guideline 4.2 — Minimum Functionality.** Apple rejects apps that are only a website in a
wrapper. This is the main risk, and the native alarm is the answer to it: the app schedules
real iOS notifications and uses haptics, so it does things a website cannot. If a reviewer
raises it anyway, say so plainly in the review notes — that the app works offline, keeps all
data on the device, and schedules native local notifications.

**Guideline 5.1.1 — Data collection.** Answer the privacy questions honestly. "Data Not
Collected" is true here and is the easiest answer to defend.

**Medical claims.** Do not describe the app as diagnosing, treating, or improving a dental
condition. It is a timer and a record keeper. The existing "not medical advice" line stays.

**Trademarks.** Do not use "Invisalign", or any other brand, in the app name, subtitle,
keywords or screenshots. It is a registered trademark of Align Technology. "Clear aligner"
is fine.

**Account deletion.** Only applies if you ever add accounts. There are none, so it does not.

---

## Android, if you want it

```bash
npm run android      # opens Android Studio
```

Google Play is a **$25 one-off** rather than yearly. Same project, same code.

---

## A word on cost

The $99/year is worth spending only if you actually want strangers to download this. For
just you, or you and family, the web app you already have costs nothing, updates instantly
without review, and works today. TestFlight (included with the developer programme) lets
you give the native build to up to 100 people without ever facing App Store review — often
the better middle ground.
