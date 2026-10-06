---
name: Lumina Finance
colors:
  surface: '#f8f9fc'
  surface-dim: '#d8dadd'
  surface-bright: '#f8f9fc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e7e8eb'
  surface-container-highest: '#e1e2e5'
  on-surface: '#191c1e'
  on-surface-variant: '#3e4a40'
  inverse-surface: '#2e3133'
  inverse-on-surface: '#eff1f3'
  outline: '#6e7a6f'
  outline-variant: '#bdcabd'
  surface-tint: '#006d3c'
  primary: '#006d3c'
  on-primary: '#ffffff'
  primary-container: '#55c481'
  on-primary-container: '#004d29'
  inverse-primary: '#6edc97'
  secondary: '#006496'
  on-secondary: '#ffffff'
  secondary-container: '#7dc5ff'
  on-secondary-container: '#00517b'
  tertiary: '#9c4148'
  on-tertiary: '#ffffff'
  tertiary-container: '#ff8f95'
  on-tertiary-container: '#78262e'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#8af9b1'
  primary-fixed-dim: '#6edc97'
  on-primary-fixed: '#00210e'
  on-primary-fixed-variant: '#00522c'
  secondary-fixed: '#cce5ff'
  secondary-fixed-dim: '#91cdff'
  on-secondary-fixed: '#001e31'
  on-secondary-fixed-variant: '#004b72'
  tertiary-fixed: '#ffdada'
  tertiary-fixed-dim: '#ffb3b5'
  on-tertiary-fixed: '#40000b'
  on-tertiary-fixed-variant: '#7d2a32'
  background: '#f8f9fc'
  on-background: '#191c1e'
  surface-variant: '#e1e2e5'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.015em
  title-md:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.005em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  amount-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  amount-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: -0.01em
  label-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.01em
  caption:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-sm: 0.75rem
  margin: 1.25rem
  margin-tablet: 2rem
  margin-desktop: 3rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.25rem
  space-xl: 1.5rem
  space-2xl: 2rem
---

## Brand & Style

This design system embodies a calm, precise, and approachable personal finance experience. It rejects high-friction corporate austerity and playful 3D cartoon gimmicks in favor of a crisp, editorial utilitarianism. The visual tone is grounded in transparency, financial calm, and effortless clarity.

Built around a modern corporate foundation softened by human-centric ergonomics, the interface prioritizes high legibility, scan-friendly financial ledgers, and tactfully subdued semantic signals. Information density is carefully calibrated: balance cards, transaction ledgers, and cash-flow insights feel airy yet structured, giving users immediate agency over their money without cognitive fatigue.

## Colors

The palette pairs a signature emerald green with balanced utility accents and an ultra-soft neutral scaffolding:

- **Primary (`#55C481`):** The signature emerald green. Used for key actions, positive trends, savings milestones, and brand focal points.
- **Secondary (`#3282B8`):** Deep balanced blue-teal. Used for received funds, inward cash flows, and neutral analytical data points.
- **Canvas (`#F7F7F7`):** Warm tinted off-white background ensuring pure white cards float effortlessly without harsh contrast.
- **Surfaces (`#FFFFFF`):** High-clarity white card backgrounds bounded by hairline borders (`#EAEAEA`).
- **Semantic Accents:**
  - **Money Out / Spent:** Muted coral (`#E76156` text/icons with `#FDEEEB` tinted badge backgrounds).
  - **Money In / Received:** Deep blue-teal (`#3282B8` text/icons with `#EAF3F9` tinted badge backgrounds).
  - **Attention / Subscriptions:** Warm amber (`#F59E0B` text/icons with `#FDF6E2` container fills).
  - **Bills / Receipts:** Soft pastel green (`#55C481` text with `#EAF7EE` container fills).
- **Text & Neutral Scale:**
  - **Text Primary:** `#1A1D1F` (high-contrast near-black for values, titles, and headers).
  - **Text Secondary:** `#6F767E` (muted graphite for captions, category markers, and timestamps).
  - **Text Tertiary / Disabled:** `#9A9FA5`.

## Typography

Inter serves as the sole typographic engine across all breakpoints. The hierarchy strictly enforces clean sentence case across headlines, subheadings, labels, and buttons, maintaining an unpretentious, friendly tone.

Numerical clarity is critical:
- Financial ledger amounts utilize tabular numbers (`font-variant-numeric: tabular-nums lining-nums`) to guarantee clean vertical alignment down transaction lists.
- Display balances use heavy semi-bold and bold weights with negative tracking (`-0.02em` to `-0.03em`) to prevent visual sprawl.
- Currency symbols are set inline, scaled slightly down, or matched directly to the amount baseline.

## Layout & Spacing

The layout is built upon an 8pt base grid with an intentional 4pt sub-grid for tight micro-alignments (such as icon-to-label offsets and badge padding).

- **Mobile Viewports (<600px):** Single-column fluid view with a mandatory `1.25rem` (20px) outer edge margin. Component padding within cards stays disciplined at `1.25rem` (20px) for container boundaries and `0.75rem` to `1rem` between stacked elements.
- **Tablet / Split Viewports (600px–1024px):** Dual-column layout utilizing a `1rem` (16px) gutter, retaining card modules at dynamic widths while maintaining standard inner padding.
- **Desktop Dashboards (>1024px):** Fixed max-width grid (max 1200px) with centered alignment, anchoring metrics to structured multi-column card clusters.

## Elevation & Depth

Depth is established primarily through quiet planar stacking and ambient diffusion rather than harsh drop shadows.

- **Flat Surface Tier:** Background canvas sits at `#F7F7F7`.
- **Card Surfaces (Elevated Level 1):** Background `#FFFFFF`, wrapped in a crisp 1px stroke of `#EAEAEA`, supported by an ultra-soft dual-stop ambient shadow: `0px 2px 4px rgba(0, 0, 0, 0.02), 0px 8px 24px rgba(0, 0, 0, 0.04)`.
- **Floating Modals & Bottom Navigation (Elevated Level 2):** Elevated interactive bars and action sheets employ `0px 12px 32px rgba(0, 0, 0, 0.08)` paired with an inner border stroke of `rgba(234, 234, 234, 0.8)`.
- **Icon containers:** Submerged micro-depth created by soft tinted background fills (e.g., `#EAF7EE` for positive receipts, `#FDEEEB` for negative spending) with zero shadow, keeping cards clean and clutter-free.

## Shapes

The geometric rhythm balances structural softness with organic hand ergonomics:

- **Primary Cards & Modals:** Outer corner radius is fixed at `20px` (`1.25rem`), providing a friendly silhouette that avoids appearing aggressively rounded.
- **Inner Embedded Containers & Input Surfaces:** Inner radius is scaled down to `12px–14px` (`rounded-lg`) to preserve optical nesting geometry within the 20px parent cards.
- **Badges, Tags, & Status Indicators:** Strict full pill geometry (`9999px`) for category pills, trend percentage badges, and filter chips.
- **Bottom Navigation Bar:** Floating dock or anchored bar with `24px` top corners or full pill encapsulation when detached from viewport edges.
- **Iconography:** Outlined vector icons drawn with a uniform `1.75px–2px` stroke weight, rounded caps, and rounded joins. Complex 3D renders, bevels, and skeuomorphic gradients are strictly excluded.

## Components

### Buttons
- **Primary:** Solid `#55C481` fill, `#FFFFFF` Inter Semi-bold text. Height: 48px on mobile for optimal touch ergonomics. Roundedness: 14px or full pill (matching context). Zero border, subtle active scale effect (`scale(0.98)`).
- **Secondary / Ghost:** `#FFFFFF` or transparent fill with a 1px `#EAEAEA` border and `#1A1D1F` text. Active state transitions to `#F7F7F7`.
- **Destructive:** Tinted container `#FDEEEB` with `#E76156` text for secondary safe actions, or solid `#E76156` for irreversible confirmation steps.

### Surface Cards
- **Overview Card:** White container (`#FFFFFF`), 20px corner radius, 1px `#EAEAEA` border. Features primary balance in `amount-lg`, secondary metric tags in full pill styling, and hairline divider lines (`#F2F2F2`) between modular rows.
- **Transaction Card / Row:** Borderless individual rows or cleanly grouped list cards. Each row contains:
  - 40px circular or 12px rounded-corner category icon tile with soft tinted background.
  - Title and timestamp stacked with 2px vertical gap.
  - Tabular aligned amount colored `#1A1D1F` (standard expense), `#3282B8` (income), or `#E76156` (outflow emphasis).

### Chips & Filter Pills
- Compact 32px height, fully rounded pill format (`rounded-full`). Unselected state: `#FFFFFF` fill with 1px `#EAEAEA` border and `#6F767E` text. Selected state: `#1A1D1F` fill with `#FFFFFF` text, or `#EAF7EE` fill with `#55C481` text for active financial filters.

### Input Fields
- Height 48px, 12px corner radius. Background `#FFFFFF`, border 1px solid `#EAEAEA`. Focus state transitions border to `#55C481` with a delicate `0 0 0 3px rgba(85, 196, 129, 0.15)` focus ring. Placeholder text set to `#9A9FA5`.

### Checkboxes & Toggle Controls
- **Switches:** 28px height, 48px width pill track. Inactive track: `#EAEAEA`. Active track: `#55C481`. Smooth 22px white circular thumb.
- **Checkboxes:** 20px square with 6px corner radius. Checked fill: `#55C481` with a crisp white 2px stroke checkmark.

### Bottom Navigation
- Anchored or floating modular container with 20px–24px curvature. Contains 4–5 core navigation items. Active item indicates selection via tinted pill background (`#EAF7EE`) or emerald icon stroke (`#55C481`) paired with an active indicator dot.