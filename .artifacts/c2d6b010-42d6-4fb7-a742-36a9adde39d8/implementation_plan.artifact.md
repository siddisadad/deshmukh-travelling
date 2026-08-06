# Implementation Plan - Live Features

Implement a comprehensive suite of live features for the Deshmukh Travelling app, including bus and flight tracking, ETA, driver contact, SOS, and boarding reminders.

## Proposed Changes

### 1. Live Tracking Enhancements (Bus)
Modify the existing `LiveTrackingWidget` to include Driver Contact and SOS buttons.

#### [MODIFY] [live_tracking_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/live_tracking/live_tracking_widget.dart)
- Add "Call Driver" button using `url_launcher`.
- Add "SOS" button with a confirmation dialog.
- Enhance the UI to show Driver details.

#### [MODIFY] [live_tracking_model.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/live_tracking/live_tracking_model.dart)
- Add state for driver info (name, phone).

### 2. Live Flight Tracking
Create a new feature for flight tracking.

#### [NEW] [flight_tracking_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/live_tracking/flight_tracking_widget.dart)
- New widget for flight tracking.
- Shows flight status (On Time, Delayed), gate info, and map with flight path.

#### [NEW] [flight_tracking_model.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/live_tracking/flight_tracking_model.dart)
- State management for flight data.

### 3. Shared Components & Services
#### [MODIFY] [firestore_service.dart](file:///A:/Workspace/deshmukh-travelling/lib/backend/firebase/firestore_service.dart)
- Add `getFlightStatusStream` to mock or fetch flight data.

### 4. Boarding Reminder
Implement a "Set Reminder" feature.

#### [MODIFY] [booking_confirmation_ticket_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/booking_confirmation_ticket/booking_confirmation_ticket_widget.dart)
- Add a "Remind Me" button.
- Integrate with `firebase_messaging` or local scheduling logic (mocked for now as local notifications aren't in pubspec, but I can use a simple UI feedback).

## Verification Plan

### Manual Verification
- Navigate to Live Tracking and verify "Call Driver" and "SOS" buttons.
- Navigate to Flight Tracking (newly created) and verify flight status display.
- Test the "Set Reminder" button in the ticket confirmation page.
