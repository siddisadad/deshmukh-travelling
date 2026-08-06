# Deshmukh Travelling App Architecture

This project follows a **Feature-First Clean Architecture** pattern.

## Directory Structure

- `lib/core/`: Shared components, utilities, and base classes.
  - `design_system/`: Centralized design tokens (colors, typography) and atomic UI components.
  - `data/`: Core data sources and base repository interfaces.
  - `logging/`: Standardized logging and observability tools.
  - `providers/`: Core Riverpod providers (Firestore, Auth, SharedPreferences).

- `lib/features/`: Feature-specific modules.
  - `[feature_name]/`:
    - `domain/`: Business logic, entities, repository interfaces, and use cases.
    - `data/`: Data models, repository implementations, and data sources.
    - `presentation/`: Riverpod providers and UI widgets.

- `lib/backend/`: (Legacy/Transition) FlutterFlow-generated schema and service logic.

## Standardized Flow

1.  **UI** (Presentation) watches a **Riverpod Provider**.
2.  **Provider** calls a **Use Case** (Domain).
3.  **Use Case** interacts with a **Repository Interface** (Domain).
4.  **Repository Implementation** (Data) fetches data from a **DataSource** (Data).
5.  **DataSource** interacts with the **API/Firestore** (Backend).

## Design System

All UI components should use tokens from `lib/core/design_system/tokens.dart` for colors, spacing, and typography to ensure consistency. Use `AppButton` instead of raw Material buttons where possible.
