import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final GestureTapCallback? onTap;
  final List<Color>? gradientColors;
  final double borderRadius;
  final bool enableShadow;
  final bool enableGlass;

  const ModernCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    this.gradientColors,
    this.borderRadius = AppSpacing.radiusXl,
    this.enableShadow = true,
    this.enableGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: enableGlass
              ? [
                  AppColors.surface.withOpacity(0.1),
                  AppColors.cardDark.withOpacity(0.1),
                ]
              : gradientColors ??
                  [
                    AppColors.surface.withOpacity(0.6),
                    AppColors.cardDark.withOpacity(0.4),
                  ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: enableGlass
              ? Colors.white.withOpacity(0.15)
              : AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: enableShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
