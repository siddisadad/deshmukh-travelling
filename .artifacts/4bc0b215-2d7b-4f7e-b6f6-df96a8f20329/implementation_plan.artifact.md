# Implementation Plan - Production Prep

This plan outlines the final steps to prepare **Deshmukh Travelling** for production, focusing on localization, branding, notifications, and quality assurance.

## User Review Required

> [!IMPORTANT]
> **Localization**: Extracting all hardcoded strings might change the way widgets are instantiated.
> **Push Notifications**: Requires a real device to test FCM tokens and requires configuration in the Firebase Console.

## Proposed Changes

### 1. [Feature] Localization (Marathi & Hindi)
- **DEPENDENCIES**: `flutter_localizations` and `intl` (already present).
- **SETUP**:
    - Create `lib/l10n/app_en.arb`, `app_mr.arb`, `app_hi.arb`.
    - Extract core strings (Select Seats, Book Now, Home, Profile, etc.).
    - Update `main.dart` to support these locales.

### 2. [Feature] Push Notifications (FCM)
- **DEPENDENCIES**: Add `firebase_messaging: ^15.3.0`.
- **LOGIC**:
    - Implement `lib/core/services/notification_service.dart`.
    - Handle background/foreground messages.
    - Ask for permission on app start.

### 3. [Branding] Splash & Icons
- **DEPENDENCIES**: Add `flutter_native_splash: ^2.4.1` and `flutter_launcher_icons: ^0.13.1`.
- **SETUP**:
    - Configure `flutter_native_splash` in `pubspec.yaml`.
    - Configure `flutter_launcher_icons` with a high-res Deshmukh logo.

### 4. [QA] Comprehensive Test Suite
- **UNIT TESTS**:
    - `test/repositories/bus_repository_test.dart`
    - `test/repositories/booking_repository_test.dart`
- **WIDGET TESTS**:
    - `test/widgets/search_form_test.dart`
    - `test/widgets/bus_seat_map_test.dart`

## Verification Plan

### Automated Tests
- Run `flutter test` to verify all new tests pass.

### Manual Verification
- **Language**: Change system language to Marathi -> Verify UI text changes.
- **Splash**: Restart app -> Verify branded splash screen appears.
- **Notifications**: Trigger a test message from Firebase Console -> Verify receipt on device.
