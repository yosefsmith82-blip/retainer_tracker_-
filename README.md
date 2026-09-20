# Aligner Tracker

A web app for tracking clear aligner (Invisalign-style) treatment — wear time, trays,
out-of-mouth sessions, appointments and notes.

Installs to your phone's home screen straight from a link. **No app store, no account,
no server.** Everything is stored on your own device.

---

## Get it on your phone

### Option 1 — install from a link (recommended)

This gives you a real app icon, full screen, offline, and reminders.

1. **Settings → Pages → Build and deployment → Source: Deploy from a branch**,
   branch **main**, folder **/ (root)**, then **Save**.
   About a minute later the site is live at
   `https://yosefsmith82-blip.github.io/retainer_tracker_-/`, and every push to `main`
   republishes it.
2. Open that URL on your phone, then:
   - **iPhone (Safari):** Share button → **Add to Home Screen**
   - **Android (Chrome):** menu ⋮ → **Install app** / **Add to Home screen**

The app then works with no signal at all.

### Option 2 — just the file

`index.html` is completely self-contained — all the code, styles and data handling are in
that one file. Email or AirDrop it to yourself and open it in your browser. Everything works,
but home-screen install and notifications need Option 1.

---

## What it does

### Wear tracking
- **Live timer** for how long the tray has been in your mouth right now.
- **Today's wear** against your daily goal (22h by default), with a bar and percentage.
- **Out-time budget** — how much longer you can have it out today and still hit the goal.

### Taking it out
Tap **Take tray out** and pick a reason. Each reason carries its own recommended allowance:

| Reason | Default |
|---|---|
| 🍽️ Meal | 30 min |
| 🍎 Snack | 15 min |
| ☕ Drink | 15 min |
| 🪥 Brushing | 10 min |
| ⏳ Other | 20 min |

All of them are editable in Settings, and you can start a one-off custom timer.

The app then counts **how long it was actually out vs. how long it was supposed to be**,
per session, per reason, and in total. The card turns amber as you approach the limit and
red once you're over.

### Reminders
- A heads-up a few minutes before your allowance is up (configurable).
- An alert the moment you're due to put it back in.
- Repeat nudges every few minutes until it's actually back in.
- A reminder when it's time to move to the next tray.
- Appointment reminders a day before and an hour before.

Reminders need notification permission (tap **Enable notifications** on the Today screen).

**The alarm** is the reliable one. When you take the tray out, the app schedules its beeps
on the Web Audio clock, which runs in the audio thread rather than in JavaScript — so they
sound at the right moment even after the phone has frozen the app in the background. A
near-silent tone holds the audio session open, since iOS suspends a context with nothing
playing. Force-quitting the app stops it; switching away does not. Settings has a volume
slider and a test button.

The app cannot create an entry in the phone's Clock app — no web app can reach it.

Notification banners are weaker: they only fire while the app is actually running. Two
things follow:

- **No time is lost.** Wear time is derived from the timestamp of when the tray came out,
  not from a running counter, so closing the app, force-quitting it, or rebooting makes no
  difference — reopen and the elapsed time is correct.
- **The 📅 button** on the out screen still builds a calendar event with an alarm, as a
  backstop for when you expect to force-quit the app or want it on a shared calendar.

### Fixing a session you logged late

Tap any out-session on the Today screen to correct when it came out, when it went back in,
or what the allowance was — for when you press the button late, or forget entirely. When
starting one, the sheet also offers **just now / 5 / 10 / 20 min ago** to backdate it.

### Report for your orthodontist
Stats → **Report for my orthodontist**. One page: compliance against your goal over the last
30 tracked days, average and best/lowest day, how many breaks ran over, current tray and
elastics, any lost or broken trays, and the notes you tagged *Ask my ortho*. Share it, print
it to PDF, or export everything as a CSV spreadsheet (every tracked day, plus every break
with its times and allowance).

### When you forget to press the button
If a break has been running for more than three hours, the app asks about it on the way in —
still out, went back in at a particular time, or never came out at all. One forgotten tap
otherwise drags a whole day's figures down.

### While the tray is out
**+5 / +15 / +30 min** extend the allowance when a meal runs long, and move the alarm with
it, rather than leaving you sitting over the limit.

### Today's forecast
Under today's wear: whether the goal is still reachable, how much slack is left, or — once
it cannot be met — the most the day can still add up to. The ring turns amber only when the
goal is genuinely out of reach, not merely because the morning is young.

### Milestones
A quarter, halfway, three quarters, every tenth tray and the final one get marked when you
advance. The Trays screen also shows the whole course as a strip, one segment per tray.

### Trays
- Which tray you're on, out of how many, and how far through the whole set you are.
- Day *n* of *N* on the current tray, and the exact date/time the next one is due.
- Average wear per day for the current tray vs. your goal.
- **Next tray** / **Back a tray** buttons, plus editing the tray number and start date if
  you started tracking partway through treatment.
- History of every finished tray with how long it took and how well you wore it.

### Adding the trays you've already been through

Trays → **Add past trays**. Tell it which tray you're on now, how many days each one lasts,
and one date — either when you started tray 1, or when you started the tray you're on now,
whichever you actually remember. It works out all the earlier trays and shows you the full
list before saving anything.

Individual trays can then be corrected: tap any row in the history to change its number or
dates, or delete it. **+ Add one tray** adds a single one by hand, for when a tray ran long
or you swapped early.

Backfilled trays are marked **not tracked** and carry dates only. The app never invents wear
figures for days before you installed it — those days show as untracked everywhere rather
than as 24 hours of perfect wear, so your averages and streaks stay truthful.

### Calendar
A month grid where each day shows how you actually did:

- A green bar for days you hit your goal, amber/red for days you didn't, nothing for days
  before you started tracking.
- Coloured dots for appointments, tray changes and notes.
- Tap any day for the detail: total wear against goal, every out-session with actual vs.
  allowed time, which tray you were on, plus that day's appointments and notes.
- Add an appointment straight onto a day from its detail view.

Appointments live on this screen too — add ortho visits with date, time, location and notes.
Upcoming and past are listed separately, with reminders before each one.

### Elastics
Record the elastics you're on — name (Chipmunk, Fox, Ram…), size, strength and how they
hook up (Class II both sides, triangle left, and so on) — plus any instructions. Change
them and the old set drops into a history with its dates, so you can see what you were
wearing when.

### Comfort
Rate each day 1–5 on the Trays screen. The chart labels each score with the day of the
tray it fell on, and works out whether your first days are worse than your later ones —
which is what should happen if a tray is doing its job.

### Lost or broken trays
Log what happened (lost, cracked, doesn't fit, thrown out), which tray, and what you did
about it. Orthodontists ask; this is the answer.

### Changing trays by wear rather than days
Optional, in Settings. A tray is meant to get days × goal-hours of actual wear. Wear it
less than that and the calendar date arrives before the tray has finished its work, so the
app can instead project the date it will have had its hours, at the rate you're actually
wearing it. **Ask your orthodontist before changing how you advance trays.**

### Hands-free with Siri
Settings lists deep links (`?out=meal`, `?out=snack`, `?in=1`). Put one in an iPhone
shortcut named "Tray out" and you can say it to Siri instead of unlocking the phone.

### Notes
Free-text notes tagged **General / Pain / Fit / Ask my ortho / Progress**, each stamped
with the tray number and date — so at your next appointment you have the actual list of
things you meant to ask.

### Stats
- This week against last: average per day, days at goal, and what moved.
- 14-day wear chart against your goal line.
- Average per day, best day, % of days you hit the goal, current streak.
- Out-of-mouth analysis: number of sessions, average length, how many ran over, and your
  total drift versus your own allowances.
- A breakdown by reason, so you can see whether it's meals or snacking that's costing you.

---

## Locking the app with Face ID

Settings → Privacy. Native builds use Face ID or Touch ID directly; the installed web app
uses the same sensor through a passkey, so it works either way (https only).

It is a **privacy screen, not encryption** — it stops someone picking up your unlocked phone
and reading your treatment history, but the data underneath is not encrypted. Two deliberate
consequences:

- If Face ID fails or is unavailable, a way past appears after a few seconds so you can
  never be locked out of your own records.
- The lock is stored separately from your data and is **not** included in backups. A backup
  restored on a new phone would otherwise ask for a credential that does not exist there.

There is no password to forget, and nothing to recover, because nothing is hidden from you.

## Your data

Stored only in this browser's local storage on your device. Nothing is uploaded anywhere,
there's no account and no analytics.

That also means: **clearing your browser data will erase it.** Settings → **Export backup**
saves a JSON file you can keep, and **Import backup** restores it (also handy for moving to
a new phone).

---

## Settings worth setting first

- **Total trays** and **days per tray** — from your treatment plan.
- **Daily wear goal** — most plans say 20–22 hours.
- **Allowances** — how long you're aiming to be out for meals, snacks and so on.

---

## Notes for developers

Plain HTML/CSS/JS, no build step, no dependencies.

| File | Purpose |
|---|---|
| `index.html` | The entire app — UI, styles and logic |
| `sw.js` | Service worker: offline cache, notification clicks |
| `manifest.webmanifest` | Install metadata |
| `icon-*.png` | App icons |

State lives under the `alignerTracker.v1` localStorage key. Wear time is derived, never
accumulated: every figure is computed by subtracting recorded out-of-mouth intervals from
elapsed time, so editing or deleting a session recalculates the history correctly.

`trackingSince` is the floor for every wear calculation, and backfilling or hand-editing a
tray start date deliberately does not move it. Without that floor, a tray dated before
install would report as fully worn for every untracked day, because no out-sessions exist
to subtract.

---

*Not medical advice. Follow your orthodontist's instructions.*
