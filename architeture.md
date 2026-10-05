# Gallery Finance AI — Flutter Frontend Architecture

## 1. Scope for the first development phase

This phase is a **frontend design prototype** for review by the project manager.

Build:

- Onboarding screens
- Login screen
- Signup screen, if required by the Supabase flow
- Logout flow
- Dashboard-first home screen
- Ask AI placeholder screen
- Bills or Receipts placeholder screen
- Transactions placeholder screen
- More/settings placeholder screen
- Privacy and permissions placeholder screen
- Account and subscription placeholder screen
- Responsive UI states using local mock data
- Navigation between screens
- Loading, empty, and error visual states where useful for the demo

Do not build yet:

- Gallery access
- OCR
- Image scanning
- AI integration
- Transaction extraction
- Supabase database tables
- Premium billing
- Subscription purchases
- Push notifications
- Background processing
- Cloud synchronization
- Currency conversion
- Real financial calculations
- Backend repositories other than authentication

The goal is to demonstrate the **visual product direction and user flow**, not to deliver a functional finance system.

---

## 2. Final technical decisions

| Area | Decision |
|---|---|
| Framework | Flutter with Dart |
| Architecture | Feature-first, lightweight clean architecture |
| State management | BLoC/Cubit via `flutter_bloc` |
| Navigation | `go_router` |
| Authentication | `supabase_flutter` |
| UI system | Material 3 with a custom design system |
| Data for design screens | Local mock data and mock repositories |
| Serialization | Avoid code generation for this phase unless needed |
| Dependency injection | Constructor injection and `RepositoryProvider` |
| Styling | Centralized theme, colors, spacing, typography, radii, and shadows |
| Testing | Widget tests for auth gate, navigation, and primary dashboard widgets |

### Why BLoC/Cubit

Use **BLoC/Cubit** because it gives the team an explicit, event-driven, testable architecture that is widely used in production Flutter applications. It is especially suitable when authentication and future integrations will grow beyond a visual prototype.

Benefits for this project:

- Clear separation between UI events and state transitions
- Predictable authentication flow
- Strong testability with bloc tests
- Easy replacement of mock repositories with real services later
- Explicit loading, success, and failure states
- Familiar structure for teams working on larger Flutter products
- Clear boundaries between presentation, domain, and data layers

Use **Cubit** for simple UI state and **Bloc** where explicit events make multiple user actions easier to understand. Use one BLoC ecosystem consistently; do not mix Riverpod, GetX, Provider, Redux, or another state-management system into this project.

### Why `go_router`

Use `go_router` for:

- Auth redirects
- Protected routes
- Nested navigation
- Deep-link readiness
- Consistent back navigation
- Clear separation between onboarding, auth, and app routes

---

## 3. Recommended project structure

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── route_names.dart
│   │   └── route_guards.dart
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       ├── app_typography.dart
│       ├── app_spacing.dart
│       ├── app_radii.dart
│       ├── app_shadows.dart
│       └── app_icons.dart
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── mock_constants.dart
│   ├── errors/
│   │   └── app_exception.dart
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   └── num_extensions.dart
│   ├── services/
│   │   └── supabase_service.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   └── formatters.dart
│   └── widgets/
│       ├── app_scaffold.dart
│       ├── app_button.dart
│       ├── app_text_field.dart
│       ├── app_card.dart
│       ├── app_section_title.dart
│       ├── app_empty_state.dart
│       ├── app_error_state.dart
│       ├── app_loading_state.dart
│       ├── app_bottom_navigation.dart
│       ├── app_avatar.dart
│       ├── app_status_badge.dart
│       └── app_snackbar.dart
│
├── features/
│   ├── onboarding/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── welcome_screen.dart
│   │   │   │   ├── privacy_intro_screen.dart
│   │   │   │   └── scan_preview_screen.dart
│   │   │   └── widgets/
│   │   │       ├── onboarding_header.dart
│   │   │       ├── onboarding_step_indicator.dart
│   │   │       └── onboarding_feature_row.dart
│   │   └── cubit/
│   │       └── onboarding_cubit.dart
│   │
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_repository.dart
│   │   │   └── supabase_auth_repository.dart
│   │   ├── domain/
│   │   │   └── auth_user.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── signup_screen.dart
│   │   │   │   └── forgot_password_screen.dart
│   │   │   └── widgets/
│   │   │       ├── auth_header.dart
│   │   │       ├── auth_text_field.dart
│   │   │       ├── auth_provider_button.dart
│   │   │       └── auth_footer_links.dart
│   │   └── bloc/
│   │       ├── auth_bloc.dart
│   │       ├── auth_event.dart
│   │       └── auth_state.dart
│   │
│   ├── home/
│   │   ├── data/
│   │   │   └── mock_dashboard_repository.dart
│   │   ├── domain/
│   │   │   ├── dashboard_summary.dart
│   │   │   └── dashboard_models.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── home_header.dart
│   │   │       ├── financial_summary_card.dart
│   │   │       ├── comparison_bars.dart
│   │   │       ├── ask_ai_card.dart
│   │   │       ├── finance_feature_grid.dart
│   │   │       ├── finance_feature_tile.dart
│   │   │       ├── data_freshness_row.dart
│   │   │       └── review_needed_row.dart
│   │   └── bloc/
│   │       ├── dashboard_cubit.dart
│   │       └── dashboard_state.dart
│   │
│   ├── ai_assistant/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── ai_assistant_screen.dart
│   │   │   └── widgets/
│   │   │       ├── ai_empty_state.dart
│   │   │       ├── suggested_prompt_chip.dart
│   │   │       └── ai_composer.dart
│   │   └── cubit/
│   │       └── ai_ui_cubit.dart
│   │
│   ├── transactions/
│   │   ├── domain/
│   │   │   └── transaction_record.dart
│   │   ├── data/
│   │   │   └── mock_transactions_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── transactions_screen.dart
│   │   │   │   └── transaction_details_screen.dart
│   │   │   └── widgets/
│   │   │       ├── transaction_list_item.dart
│   │   │       ├── transaction_filter_button.dart
│   │   │       └── transaction_empty_state.dart
│   │   └── cubit/
│   │       └── transactions_cubit.dart
│   │
│   ├── bills/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── bills_screen.dart
│   │   │   └── widgets/
│   │   │       └── bill_summary_tile.dart
│   │   └── cubit/
│   │       └── bills_cubit.dart
│   │
│   ├── subscriptions/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── subscriptions_screen.dart
│   │   │   └── widgets/
│   │   │       └── subscription_summary_tile.dart
│   │   └── cubit/
│   │       └── subscriptions_cubit.dart
│   │
│   ├── settings/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── more_screen.dart
│   │   │   │   ├── privacy_settings_screen.dart
│   │   │   │   ├── data_management_screen.dart
│   │   │   │   └── account_settings_screen.dart
│   │   │   └── widgets/
│   │   │       ├── settings_section.dart
│   │   │       ├── settings_tile.dart
│   │   │       └── account_header.dart
│   │   └── cubit/
│   │       └── settings_cubit.dart
│   │
│   └── shared/
│       ├── widgets/
│       │   ├── feature_tile.dart
│       │   ├── metric_value.dart
│       │   ├── direction_icon.dart
│       │   └── section_header.dart
│       └── models/
│           └── app_enums.dart
│
├── l10n/
│   └── app_en.arb
│
└── assets/
    ├── icons/
    ├── illustrations/
    └── images/
```

### Structure rules

- Keep code inside the feature that owns it.
- Place a widget in `core/widgets` only if it is genuinely generic and reused across multiple features.
- Do not create a global `components` folder containing every widget.
- Do not place business logic in screen files.
- Keep each screen responsible for composition and layout, not data access.
- Keep mock data behind repositories and Cubits so real integrations can replace them later.
- Avoid creating empty layers that have no current purpose.

---

## 4. App startup and dependency setup

### `main.dart` responsibilities

`main.dart` should:

1. Ensure Flutter bindings are initialized.
2. Initialize Supabase using environment configuration.
3. Create the app's BLoC and repository dependencies.
4. Avoid containing UI or business logic.

Example dependency set for this phase:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.0
  go_router: ^14.8.1
  supabase_flutter: ^2.8.0
  intl: ^0.19.0
```

Use the current compatible versions when creating the project. Do not add packages for gallery access, OCR, charts, payments, or AI yet.

### Supabase configuration

Do not hard-code Supabase credentials in source files. Use `--dart-define` values or a local environment strategy that is excluded from version control.

Required values:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
```

The anon key is intended for client applications, but never commit project secrets or service-role keys.

---

## 5. Authentication architecture

Authentication is the only real integration in this phase.

### Auth responsibilities

Implement:

- Email/password login
- Email/password signup if required
- Session restoration on app launch
- Logout
- Auth loading state
- Auth error state
- Basic validation
- Protected app routes

Social login, password reset, email confirmation UI, and account deletion can be added if the project manager requests them, but they are not required for the first visual demo.

### Auth repository interface

Keep the UI independent from the Supabase SDK by using a small repository boundary:

```dart
abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  AuthUser? get currentUser;
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
```

`SupabaseAuthRepository` implements this interface. A fake repository can be used in widget tests.

### Auth BLoC

Use an `AuthBloc` that exposes:

```text
initializing
signedOut
signedIn
error
```

The app router should react to the auth state and redirect:

- Signed out → `/login`
- Signed in → `/home`
- Auth initialization → splash/loading screen

Recommended events:

```text
AuthSessionStarted
AuthLoginRequested
AuthSignupRequested
AuthLogoutRequested
```

Recommended states:

```text
AuthInitial
AuthLoading
AuthUnauthenticated
AuthAuthenticated
AuthFailure
```

Do not manually push the user to Home from every login button. Add an event to `AuthBloc`, update the auth state, and let the router perform the redirect.

### Logout flow

From Account or More:

1. User taps Sign out.
2. Show a lightweight confirmation dialog.
3. Call `authController.signOut()`.
4. Supabase session ends.
5. Router redirects to Login.
6. Clear only local UI state that belongs to the authenticated session.

---

## 6. Routing map

```text
/
├── /splash
├── /onboarding
│   ├── /onboarding/welcome
│   ├── /onboarding/privacy
│   └── /onboarding/preview
├── /login
├── /signup
└── /app
    ├── /home
    ├── /ai
    ├── /transactions
    ├── /bills
    ├── /subscriptions
    ├── /more
    ├── /settings/privacy
    ├── /settings/data
    ├── /settings/account
    └── /transactions/:transactionId
```

Use a shell route for the authenticated area so the bottom navigation remains persistent across:

- Home
- Bills or Records
- Transactions
- AI

The More screen can open as a normal nested route.

### Navigation rules

- Use `push` for detail screens.
- Use shell navigation for primary destinations.
- Preserve the selected bottom-navigation tab.
- Use `replace` after successful authentication where appropriate.
- Do not allow signed-out users to access authenticated screens.
- Keep onboarding state local and temporary in this phase.

---

## 7. Dashboard implementation scope

The Home screen should use local mock data through a repository injected into `DashboardCubit`.

### Dashboard sections

Implement these sections:

1. Header with avatar and greeting.
2. Period selector, visually functional if possible.
3. Green financial summary card.
4. Spent and Received values.
5. Simplified comparison bars.
6. Data freshness row.
7. Ask AI shortcut card.
8. Explore your finances section.
9. Bills/Receipts tile.
10. Subscriptions tile.
11. Transactions tile.
12. Optional review-needed row.
13. Persistent bottom navigation.

### Mock dashboard model

```dart
class DashboardSummary {
  final String periodLabel;
  final String currency;
  final double spent;
  final double received;
  final int recordCount;
  final int imageCount;
  final int reviewCount;
  final DateTime lastUpdated;
}
```

Use fictional sample values:

```text
Period: This month
Currency: PKR
Spent: 5,000
Received: 4,000
Records: 126
Images: 20
Review needed: 6
Subscriptions: 245 this month
```

The dashboard should be visually convincing, but none of these values should be treated as real financial data.

---

## 8. State management plan

Keep state intentionally small during the design phase, but make all important transitions explicit.

### Use BLoC for app-level workflows

Use `AuthBloc` for:

- Supabase session restoration
- Login
- Signup
- Logout
- Authentication loading and failure states

Use `DashboardBloc` only if the dashboard will soon gain multiple events such as period changes, refresh, or scan updates. Otherwise, use `DashboardCubit` for the current mock dashboard.

### Use Cubit for simple feature state

Use Cubits for:

- Selected dashboard period
- Mock dashboard summary
- Mock transactions
- Mock bills
- Mock subscriptions
- AI empty state and suggested prompts
- Settings screen toggles used only for the prototype

Suggested classes:

```text
AuthBloc
DashboardCubit
TransactionsCubit
BillsCubit
SubscriptionsCubit
AiUiCubit
SettingsCubit
```

### State conventions

Each BLoC or Cubit should expose clear states such as:

```text
initial
loading
loaded
success
failure
```

For authentication, use the more specific states defined in the AuthBloc section.

Events should describe user intent:

```text
AuthLoginRequested
AuthLogoutRequested
DashboardPeriodChanged
TransactionsRequested
```

Do not put Supabase calls, mock repository calls, or navigation logic directly inside widgets.

### Local widget state

Use `StatefulWidget` local state only for short-lived presentation state such as:

- Password visibility
- Expanded/collapsed sections
- Temporary selected chip
- Dialog open state
- Animation controllers

Do not create a Cubit for a single ephemeral boolean that never leaves one widget.

### Dependency injection

Create repositories once near the app root and inject them into BLoCs/Cubits using constructors and `RepositoryProvider` or `BlocProvider`.

Example hierarchy:

```text
RepositoryProvider<AuthRepository>
  └── BlocProvider<AuthBloc>
        └── MaterialApp.router
```

Keep `BuildContext` usage inside the presentation layer. Keep repositories independent of widgets.

### Async UI convention

For async BLoC/Cubit operations, support:

- `loading`
- `data`
- `error`

Every async UI state must have a designed visual treatment. Do not leave blank space or show an indefinite spinner.

---

## 9. Design system implementation

Create the visual system before building individual screens.

### `AppColors`

Start with the existing Figma direction:

```dart
class AppColors {
  static const background = Color(0xFFF7F7F7);
  static const primaryGreen = Color(0xFF55C481);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF101828);
  static const textSecondary = Color(0xFF667085);
  static const border = Color(0xFFE4E7EC);
  static const outgoing = Color(0xFFE86A6A);
  static const incoming = Color(0xFF347C70);
  static const warning = Color(0xFFA86B16);
}
```

Treat these as initial tokens. Do not scatter raw hex values throughout widgets.

### Theme

Use Material 3 with:

- Light color scheme
- Inter or the chosen app font
- Consistent input decoration
- Consistent button shapes
- Consistent card theme
- Consistent bottom navigation theme

### Reusable visual tokens

Centralize:

- Colors
- Typography
- Spacing
- Border radii
- Shadows
- Icon sizes
- Minimum tap target sizes

The Figma dimensions should guide the Flutter implementation, but do not hard-code absolute positions from Figma. Recreate the layout with responsive `Padding`, `Row`, `Column`, `Expanded`, `Flexible`, `Wrap`, and `LayoutBuilder` widgets.

---

## 10. Screen delivery order

Build in this order:

### Phase 1 — Foundation

1. Create Flutter project.
2. Add `flutter_bloc`, `go_router`, `supabase_flutter`, and `intl`.
3. Create theme and design tokens.
4. Create app shell and router.
5. Add Supabase initialization.

### Phase 2 — Authentication

1. Splash/auth-loading screen.
2. Login screen.
3. Signup screen if needed.
4. Auth repository.
5. AuthBloc and authentication states.
6. Protected-route redirects.
7. Logout dialog and action.

### Phase 3 — Dashboard

1. App shell with bottom navigation.
2. Home header.
3. Financial summary card.
4. Comparison bars.
5. Ask AI card.
6. Feature tiles.
7. Data freshness and review states.
8. Responsive layout refinement.

### Phase 4 — Supporting visual screens

1. AI placeholder screen.
2. Transactions list with mock data.
3. Transaction details with mock data.
4. Bills/Receipts placeholder.
5. Subscriptions placeholder.
6. More/settings screen.
7. Privacy and data-management placeholders.

### Phase 5 — Demo quality

1. Add loading and empty states.
2. Add sign-out flow.
3. Add route transitions only where useful.
4. Test small and large phone widths.
5. Test keyboard and safe areas.
6. Remove debug UI and placeholder labels.
7. Prepare the project-manager demo flow.

---

## 11. Demo flow for the project manager

The cleanest demo should be:

```text
Launch app
  ↓
Splash / session check
  ↓
Login
  ↓
Home dashboard
  ↓
Tap period selector
  ↓
Show dashboard summary
  ↓
Tap Ask AI placeholder
  ↓
Return to Home
  ↓
Open Transactions
  ↓
Open a transaction detail
  ↓
Open More / Settings
  ↓
Sign out
  ↓
Return to Login
```

Use a demo Supabase account or a controlled test account. Do not put credentials in the repository or screenshots.

---

## 12. Testing requirements

At minimum, add tests for:

- Login success navigates to Home.
- Login failure displays an error state.
- Signed-out users are redirected to Login.
- Signed-in users can access the shell.
- Logout returns to Login.
- Dashboard renders mock spent and received values.
- Bottom navigation changes the selected screen.
- Transaction item opens transaction details.
- Empty and loading states render without exceptions.

Use widget tests for UI and bloc tests for authentication and Cubit logic. No integration test suite is required for the first visual phase.

---

## 13. What should be deliberately postponed

Do not prematurely create these folders or abstractions:

- OCR services
- Gallery repositories
- AI clients
- Payment repositories
- Subscription entitlement services
- Transaction sync services
- Analytics event systems
- Notification services
- Background workers
- Complex domain use cases
- Remote feature-flag infrastructure

When those features begin, add them inside their own feature modules instead of modifying unrelated UI files.

---

## Final architecture decision

Use this as the official first-phase direction:

> **Feature-first Flutter architecture + BLoC/Cubit + go_router + Supabase Auth + Material 3 custom design tokens + local mock repositories for every non-auth screen.**

Build the product as a polished dashboard-first visual prototype. Keep authentication real, keep everything else mocked, and structure the code so future gallery, AI, transactions, subscriptions, and Premium integrations can be added without rewriting the UI.
