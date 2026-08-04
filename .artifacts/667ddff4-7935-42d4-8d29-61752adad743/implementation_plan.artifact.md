# Phase 1 – Foundation (MVP) Implementation Plan

This plan outlines the steps to implement the core features of the Deshmukh Travelling bus booking application. The project is built with Flutter and uses Firebase for the backend.

## User Review Required

> [!IMPORTANT]
> **OTP Login**: OTP verification requires a valid Firebase configuration with Phone Auth enabled. Please ensure your Firebase project is set up correctly.
> **Payment Integration**: The plan assumes a placeholder for payments unless a specific provider (like Razorpay or Stripe) is requested.

## Proposed Changes

### 1. Foundation & Authentication
Finalize the initial entry points and user identification.

#### [MODIFY] [main.dart](file:///A:/Workspace/deshmukh-travelling/lib/main.dart)
- Ensure all initializers (Firebase, Notifications) are robust.
- Verify routing logic for deep links if needed for QR tickets.

#### [MODIFY] [splash_onboarding_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/splash_onboarding/splash_onboarding_widget.dart)
- Implement multi-step onboarding carousel using `PageView` or similar components.
- Add "Skip" functionality.

#### [MODIFY] [login_o_t_p_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/login_o_t_p/login_o_t_p_widget.dart)
- Implement full Firebase Phone Auth flow (requesting code, verification, auto-retrieval).
- Add error handling for invalid OTPs and timeouts.

---

### 2. Bus Search & Discovery
The core value proposition: finding the right bus.

#### [MODIFY] [home_dashboard_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/home_dashboard/home_dashboard_widget.dart)
- Implement search form: From/To location pickers and Date picker.
- Add recent searches section.

#### [MODIFY] [bus_search_results_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/bus_search_results/bus_search_results_widget.dart)
- Implement Firestore queries for buses based on search criteria.
- Integrate filter logic (Time, Price, Bus Type, Amenities).
- Display bus cards with key info (Arrival/Departure, Duration, Price, Seats left).

---

### 3. Booking Workflow
Selection, details, and payment.

#### [MODIFY] [seat_selection_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/seat_selection/seat_selection_widget.dart)
- Dynamic seat map rendering based on bus layout.
- Real-time seat status (available, selected, occupied).

#### [MODIFY] [passenger_details_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/passenger_details/passenger_details_widget.dart)
- Form for multiple passengers (Name, Age, Gender).
- Integration with user profile for auto-fill.

#### [MODIFY] [payment_checkout_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/payment_checkout/payment_checkout_widget.dart)
- Summary of booking.
- Payment method selection.
- Execution of payment and creation of `booking_record` in Firestore.

---

### 4. Post-Booking & Profile
Managing the trip and account.

#### [MODIFY] [booking_confirmation_ticket_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/booking_confirmation_ticket/booking_confirmation_ticket_widget.dart)
- Generate and display QR code containing booking ID.
- Add "Download Ticket" (PDF) using `pdf` and `printing` packages.
- Add "Share Ticket" functionality.

#### [MODIFY] [my_trips_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/my_trips/my_trips_widget.dart)
- List current and past bookings from Firestore.
- Add "Cancel Booking" or "View Details" actions.

#### [MODIFY] [profile_settings_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/profile_settings/profile_settings_widget.dart)
- Edit profile (Name, Email, Profile Picture).
- Notification preferences.

---

### 5. Notifications
System alerts for user engagement.

#### [MODIFY] [notification_service.dart](file:///A:/Workspace/deshmukh-travelling/lib/core/services/notification_service.dart)
- Implement FCM (Firebase Cloud Messaging) initialization.
- Handle background and foreground notifications.

## Verification Plan

### Automated Tests
- `flutter test` for utility functions (date formatting, price calculations).
- Widget tests for critical forms (Login, Passenger Details).

### Manual Verification
1.  **Auth**: Run app, enter phone number, receive OTP (test mode), and log in.
2.  **Search**: Search for a bus, apply filters, and verify results match Firestore data.
3.  **Booking**: Complete a full booking flow and verify `booking_record` appears in Firestore.
4.  **Ticket**: View the QR ticket and test sharing/downloading.
5.  **Notifications**: Trigger a test notification from Firebase Console.
