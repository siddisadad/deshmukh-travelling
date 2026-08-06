# Profile Upgrade Implementation Plan

This plan upgrades the Profile screen (`ProfileSettingsWidget`) to include Travel History, Rewards, Wallet, Saved Cards, Saved Travelers, Saved Hotels, Saved Routes, Membership Status, and Badges.

## User Review Required

> [!IMPORTANT]
> Some new sections like **Saved Hotels**, **Saved Routes**, and **Saved Cards** may not have existing target pages. I will use placeholders for these routes for now.

> [!NOTE]
> I am reorganizing the menu into logical groups: **Travel Hub** and **Wallet & Payments** to improve discoverability.

## Proposed Changes

### Profile Screen Component

#### [MODIFY] [profile_settings_widget.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/profile_settings/profile_settings_widget.dart)
- Rename "Saved Passengers" section to **Saved Travelers**.
- Add a new **Travel Hub** section containing:
    - **Travel History** (linking to existing MyTripsWidget)
    - **Saved Hotels** (placeholder)
    - **Saved Routes** (placeholder)
- Add a new **Wallet & Payments** section containing:
    - **Wallet** (linking to existing WalletWidget)
    - **Saved Cards** (placeholder)
    - **Rewards** (linking to existing WalletWidget/Rewards placeholder)
- Add **Membership Status** and **Badges** indicators, potentially in the header or as a new "Achievements" section.

#### [MODIFY] [profile_settings_model.dart](file:///A:/Workspace/deshmukh-travelling/lib/pages/profile_settings/profile_settings_model.dart)
- Initialize additional `ProfileMenuItemModel` instances for the new menu items.

## Verification Plan

### Manual Verification
- Open the Profile screen and verify all new menu items are visible.
- Check that "Saved Passengers" is now "Saved Travelers".
- Verify that the layout remains clean and follows the app's design system.
