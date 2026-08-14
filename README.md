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

**These only fire while the app is open.** Phones suspend web apps in the background, so
nothing runs once you switch away — no timer can tick and no notification can fire without
a server pushing it. Two things follow from that:

- **No time is lost.** Wear time is derived from the timestamp of when the tray came out,
  not from a running counter, so closing the app, force-quitting it, or rebooting makes no
  difference — reopen and the elapsed time is correct.
- **For the alert, use ⏰ Set a phone alarm** on the out-of-mouth screen. It builds a
  calendar event with an alarm at your due time and hands it to the phone's own calendar,
  which does go off with the app closed.

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

### Notes
Free-text notes tagged **General / Pain / Fit / Ask my ortho / Progress**, each stamped
with the tray number and date — so at your next appointment you have the actual list of
things you meant to ask.

### Stats
- 14-day wear chart against your goal line.
- Average per day, best day, % of days you hit the goal, current streak.
- Out-of-mouth analysis: number of sessions, average length, how many ran over, and your
  total drift versus your own allowances.
- A breakdown by reason, so you can see whether it's meals or snacking that's costing you.

---

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
