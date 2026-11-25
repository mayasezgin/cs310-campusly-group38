# Campusly: Campus Cafeteria & Events App

A Flutter mobile app that shows the daily cafeteria menu and upcoming campus events in one place, with reminders for events students want to attend. Clubs can log in and post their own events.

## Description

Students currently check several websites, posters, and social media accounts to find out what is on the cafeteria menu or which club events are coming up. Campusly brings this information together and sends reminders.

**Core features**
- Daily and weekly cafeteria menu
- Campus events list with details
- Filter events by category
- Favorite / "I'm going" events
- Reminder notification before a saved event
- Club login (Firebase Authentication)
- Add event form with input validation (for logged-in clubs)

## Group Details

- **Course:** CS310 Mobile Application Development
- **Group number:** 38

| Name | Student ID | GitHub username |
|------|------------|-----------------|
| Maya Sezgin | 31989 | mayasezgin |
| Aziz Çiftçi | 32059 | azizciftci |
| Khadija Guliyeva | 32706 | KhadijaGuliyeva |

## Tech Stack

- Flutter (Dart)
- Firebase Firestore (menu and event data)
- Firebase Authentication (club accounts)
- Local storage for favorites and reminders

## Requirements

- Flutter 3.41.2 (stable channel, Dart 3.11.0). Check with `flutter --version`.
- For Android builds: a JDK from 17 to 25 (developed and tested with JDK 21). The
  Android build uses Gradle 9.1.0, Android Gradle Plugin 8.11.1 and Kotlin 2.2.20.
- If `flutter doctor` reports Android licenses that are not accepted, run
  `flutter doctor --android-licenses`.

Flutter picks the JDK for Android builds in this order: the JDK set with
`flutter config --jdk-dir`, the JDK bundled with Android Studio, `JAVA_HOME`,
then `java` on the PATH. To see which one it uses, run the command below and
read the "Java version" line under "Android toolchain":

```sh
flutter doctor -v
```

If the Android build fails with a Java or Gradle version error, point Flutter
at a JDK 21 and try again:

```sh
flutter config --jdk-dir="<path to JDK 21>"
flutter clean
flutter run
```

On macOS the path is printed by `/usr/libexec/java_home -v 21`.
To undo this later, run `flutter config --jdk-dir=""`.

## Getting Started

This project was set up with Flutter 3.41.2 (stable).

With an Android or iOS device, emulator, or simulator available, run these
commands from the repository root:

```sh
flutter pub get
flutter run
```
