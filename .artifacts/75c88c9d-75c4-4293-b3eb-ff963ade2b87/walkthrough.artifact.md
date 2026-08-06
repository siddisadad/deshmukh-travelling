# Walkthrough - Hajj & Umrah Module

The Hajj & Umrah module has been successfully integrated into the Deshmukh Travel application. This module provides a premium, enterprise-grade experience for pilgrims, focusing on ease of use and spiritual guidance.

## Key Features Implemented

### 🕋 Hajj & Umrah Dashboard
The central hub for all religious travel needs. It displays upcoming journeys, booked packages, and quick actions for prayer times and dua guides.

### 📜 Package Management
- **Listing**: Browse Hajj and Umrah packages with clear pricing, duration, and departure dates.
- **Details**: In-depth view of hotels, flights, and day-wise itineraries.
- **Booking Flow**: Streamlined passenger detail entry and booking confirmation.

### ✈️ My Journey & Documents
- **Tracking**: Real-time status of Visa, Flight, and Hotel allocations.
- **Document Vault**: Easy access to Passport, Visa, Tickets, and Vouchers with offline capability.

### 🕌 Islamic Tools
- **Prayer Times**: Accurate timings based on location.
- **Qibla Finder**: Visual compass for orientation.
- **Dua Guide**: Comprehensive collection of supplications for every stage of the pilgrimage (Ihram, Tawaf, Sa'i, etc.) with Arabic, Transliteration, and Translation.
- **Tasbeeh Counter**: Simple, accessible digital counter.

## Technical Implementation

- **Architecture**: Clean Architecture (Domain, Data, Presentation).
- **State Management**: Riverpod for efficient, reactive state.
- **UI/UX**: Material 3 with a custom Emerald Green (#06402B) and Gold (#D4AF37) palette.
- **Responsiveness**: Fully adaptive layouts for different screen sizes.
- **Accessibility**: Large typography and high-contrast elements for elderly pilgrims.

## Integration Points

1. **Home Screen**: A new premium card and service selector item for "Hajj & Umrah".
2. **Navigation**: 6 new routes registered in `nav.dart`.
3. **Design System**: Reusable Islamic-themed widgets added to the project.

## Verification
- ✅ Domain entities and repository logic verified.
- ✅ State providers for packages and bookings tested.
- ✅ All UI screens verified for layout and navigation consistency.
