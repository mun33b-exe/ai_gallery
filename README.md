# Gallery Finance AI

Production-grade visual finance intelligence application built with Flutter, Material 3, BLoC/Cubit, GoRouter, and Supabase.

## Architecture Blueprint

This repository is organized following an enterprise feature-first structure:

```
lib/
├── app/                  # Application lifecycle, routing (GoRouter), theme & design tokens
├── core/                 # Shared widgets, utilities, formatters, services, errors
├── features/             # Feature domains (auth, home, onboarding, transactions, bills, subscriptions, ai_assistant, settings)
│   ├── <feature>/
│   │   ├── data/         # Repositories & data sources
│   │   ├── domain/       # Entities & value models
│   │   ├── bloc|cubit/   # State management
│   │   └── presentation/ # Screens & widgets
└── l10n/                 # Localization resources
```

### State Management Guidelines
- **Bloc**: Workflows with explicit discrete events (`AuthBloc` handles `AuthSessionStarted`, `AuthLoginRequested`, `AuthSignupRequested`, `AuthLogoutRequested`).
- **Cubit**: Simple UI states (`DashboardCubit`, `OnboardingCubit`).
- No secondary state management (Riverpod, Provider, GetX, etc.) is introduced.

## Running the Application

### 1. Blueprint Preview Mode (Default)
When no remote Supabase credentials are provided, the application runs safely in design blueprint preview mode with local mock repositories:

```bash
flutter run
```

### 2. With Supabase Authentication
To connect to your Supabase backend, supply compile-time environment variables using `--dart-define`:

```bash
flutter run \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

> **Security Note:** Secrets are never committed or printed in logs. Never use Supabase `service_role` keys in client-side applications.

## Design System Tokens

- **Background:** `#F7F7F7`
- **Primary Brand Green:** `#55C481`
- **Surface:** `#FFFFFF`
- **Primary Text:** `#101828`
- **Secondary Text:** `#667085`
- **Border:** `#E4E7EC`
- **Outgoing Flow:** Muted coral / warm red (`#E05D52`)
- **Incoming Flow:** Deep teal / blue-green (`#0E8472`)
- **Warning / Review:** Muted amber (`#E69A19`)
- **Grid:** 8-point spacing grid, 12-20px card radii, soft elevation shadows.

## Scope & Intentional Postponements

**Included in this blueprint:**
1. Complete feature-first project structure and design system tokens.
2. GoRouter setup with persistent bottom navigation shell (`Home`, `Bills`, `Transactions`, `Ask AI`) and secondary screens.
3. Supabase authentication architecture boundary with safe mock fallback.
4. Home dashboard matching Figma visual blueprint (summary card, comparison bars, Ask AI prompt, feature shortcuts).
5. Navigable blueprint placeholders for all target screens.

**Intentionally postponed to subsequent phases:**
- Native camera and photo gallery permissions (`photo_manager`, `image_picker`)
- On-device and cloud OCR
- Remote AI assistant inference & streaming
- Live database persistence tables
- Real financial calculations & bank statement parsing
- Billing, in-app purchases, and StoreKit entitlements
