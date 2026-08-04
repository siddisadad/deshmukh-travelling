# Task List - Production Prep

## Phase 1: Localization (L10n)
- [x] Create `lib/l10n/` directory and ARB files (`app_en.arb`, `app_mr.arb`, `app_hi.arb`)
- [x] Add `generate: true` to `pubspec.yaml`
- [x] Create `l10n.yaml` configuration
- [x] Extract core strings from main widgets
- [x] Update `main.dart` with localization delegates

## Phase 2: Push Notifications (FCM)
- [x] Add `firebase_messaging` to `pubspec.yaml`
- [x] Implement `NotificationService`
- [x] Initialize FCM in `main.dart`
- [x] Request permissions on startup
- [x] Fix Web Service Worker MIME type issue

## Phase 3: Branding & Assets
- [x] Add `flutter_native_splash` and `flutter_launcher_icons`
- [x] Configure splash screen in `pubspec.yaml`
- [x] Configure launcher icons in `pubspec.yaml`
- [x] Run generation commands for splash and icons

## Phase 4: Quality Assurance (Testing)
- [x] Create repository tests (`bus_repository_test.dart`, `booking_repository_test.dart`)
- [x] Create widget tests for modular components
- [x] Verify all tests pass
