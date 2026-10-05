import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/utils/responsive.dart';

class FinanceFeatureGrid extends StatelessWidget {
  const FinanceFeatureGrid({super.key});

  static const Color billingBgColor = Color(0xFFA1E2BB);
  static const Color billingTextColor = Color(0xFF224F34);

  static const Color subscriptionBgColor = Color(0xFFFDE37F);
  static const Color subscriptionTextColor = Color(0xFF967300);

  static const Color transactionBgColor = Color(0xFFC8BDF1);
  static const Color transactionTextColor = Color(0xFF4B0082);

  @override
  Widget build(BuildContext context) {
    final gap = Responsive.spacing(context, 12, min: 8, max: 16);
    final cardRadius = Responsive.value<double>(
      context,
      compact: 18.0,
      normal: 22.0,
      large: 24.0,
    );
    final iconSize = Responsive.iconSize(
      context,
      designSize: 46,
      min: 38,
      max: 52,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Column: Tall Bills Card
          Expanded(
            child: _TallFeatureCard(
              title: 'Bills',
              subtitle: 'Billing',
              iconPath: 'assets/icons/billing_icon.svg',
              backgroundColor: billingBgColor,
              textColor: billingTextColor,
              borderRadius: BorderRadius.circular(cardRadius),
              iconSize: iconSize,
              onTap: () => context.go(RouteNames.bills),
            ),
          ),
          SizedBox(width: gap),

          // Right Column: Stacked Subscriptions and Transactions Cards
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _StackedFeatureCard(
                    title: 'Subscriptions',
                    iconPath: 'assets/icons/subscription.svg',
                    backgroundColor: subscriptionBgColor,
                    textColor: subscriptionTextColor,
                    borderRadius: BorderRadius.circular(cardRadius),
                    iconSize: iconSize,
                    onTap: () => context.go(RouteNames.subscriptions),
                  ),
                ),
                SizedBox(height: gap),
                Expanded(
                  child: _StackedFeatureCard(
                    title: 'Transactions',
                    iconPath: 'assets/icons/coins_icon.svg',
                    backgroundColor: transactionBgColor,
                    textColor: transactionTextColor,
                    borderRadius: BorderRadius.circular(cardRadius),
                    iconSize: iconSize,
                    onTap: () => context.go(RouteNames.transactions),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper to render icons reliably across SVG vectors and embedded PNG images.
class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.assetPath, required this.size});

  final String assetPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final pngPath = assetPath.endsWith('.svg')
        ? assetPath.replaceAll('.svg', '.png')
        : assetPath;

    return Image.asset(
      pngPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

/// Left tall card displaying icon at the top and title/subtitle at the bottom.
class _TallFeatureCard extends StatelessWidget {
  const _TallFeatureCard({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.iconSize,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius borderRadius;
  final double iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.spacing(context, 18, min: 14, max: 22);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top icon
                _FeatureIcon(assetPath: iconPath, size: iconSize),
                const SizedBox(height: 24),

                // Bottom Title & Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 20,
                          min: 18,
                          max: 24,
                        ),
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.8),
                        fontSize: Responsive.fontSize(
                          context,
                          designSize: 14,
                          min: 12,
                          max: 16,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Right stacked card displaying icon at the top and title at the bottom.
class _StackedFeatureCard extends StatelessWidget {
  const _StackedFeatureCard({
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.iconSize,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius borderRadius;
  final double iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.spacing(context, 16, min: 12, max: 20);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top icon
                _FeatureIcon(assetPath: iconPath, size: iconSize),
                const SizedBox(height: 12),

                // Bottom Title
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: Responsive.fontSize(
                      context,
                      designSize: 18,
                      min: 16,
                      max: 22,
                    ),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
