# Implementation Plan - Separate Header and Footer Logic

The goal is to extract the header and footer logic from individual pages into reusable widgets. This will improve code maintainability, consistency, and reduce the size of the page widgets.

## User Review Required

> [!NOTE]
> This refactor will introduce new reusable components. I will start by refactoring the `HomeDashboardWidget` and `MyTripsWidget` to demonstrate the pattern.

## Proposed Changes

### [Component Name] Reusable UI Components

I will create new components for the header and footer.

#### [NEW] [app_header.dart](file:///A:/Workspace/deshmukh-travelling/lib/components/app_header.dart)
A reusable header component for standard pages (like My Trips, Profile).

#### [NEW] [home_header.dart](file:///A:/Workspace/deshmukh-travelling/lib/components/home_header.dart)
A specialized header component for the Home Dashboard.

#### [NEW] [app_nav_bar.dart](file:///A:/Workspace/deshmukh-travelling/lib/components/app_nav_bar.dart)
A reusable bottom navigation bar component.

### [Component Name] Pages Refactoring

#### [MODIFY] [home_dashboard_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/home_dashboard/home_dashboard_widget.dart)
Extract the header section and add the new `AppNavBar`.

#### [MODIFY] [my_trips_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/my_trips/my_trips_widget.dart)
Extract the header section and add the new `AppNavBar`.

## Verification Plan

### Manual Verification
- Run the app and verify that the Header on the Home page looks and functions exactly as before.
- Verify that the Header on the My Trips page looks and functions exactly as before.
- Verify that the new Bottom Navigation Bar appears on both pages and allows navigation between them.
