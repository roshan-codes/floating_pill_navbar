import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../floating_pill_destination.dart';
import '../floating_pill_theme.dart';

/// An individual navigation item rendered inside [FloatingPillNavBar].
class NavigationItemWidget extends StatelessWidget {
  /// Creates an individual navigation item.
  const NavigationItemWidget({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onTap,
    required this.theme,
    this.showLabel,
  });

  /// Destination data for this item.
  final FloatingPillDestination destination;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Callback executed when this item is tapped.
  final VoidCallback onTap;

  /// The active theme data.
  final FloatingPillThemeData theme;

  /// Optional override for label visibility.
  final bool? showLabel;

  void _handleTap() {
    if (theme.enableHapticFeedback) {
      HapticFeedback.selectionClick();
    }
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShowLabel =
        (destination.showLabel ?? showLabel ?? theme.showLabels) &&
            destination.label != null &&
            destination.label!.isNotEmpty;

    final Duration duration =
        theme.enableAnimation ? theme.animationDuration : Duration.zero;
    final Curve curve = theme.animationCurve;

    final Color targetBgColor =
        isSelected ? theme.selectedBackgroundColor : Colors.transparent;

    final Color targetIconColor =
        isSelected ? theme.selectedIconColor : theme.unselectedIconColor;

    final double targetIconSize =
        isSelected ? theme.selectedIconSize : theme.unselectedIconSize;

    final Color targetLabelColor =
        isSelected ? theme.selectedLabelColor : theme.unselectedLabelColor;

    final double targetFontSize =
        isSelected ? theme.selectedFontSize : theme.unselectedFontSize;

    final FontWeight targetFontWeight =
        isSelected ? theme.selectedFontWeight : theme.unselectedFontWeight;

    final String semanticLabel =
        destination.tooltip ?? destination.label ?? 'Navigation item';

    Widget content = AnimatedContainer(
      duration: duration,
      curve: curve,
      padding: theme.selectedItemPadding,
      decoration: BoxDecoration(
        color: targetBgColor,
        borderRadius: theme.selectedItemBorderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildIconWithBadge(
            context,
            targetIconColor: targetIconColor,
            targetIconSize: targetIconSize,
            duration: duration,
            curve: curve,
          ),
          if (shouldShowLabel) ...<Widget>[
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: duration,
              curve: curve,
              style: TextStyle(
                color: targetLabelColor,
                fontSize: targetFontSize,
                fontWeight: targetFontWeight,
                letterSpacing: -0.1,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Text(destination.label!),
            ),
          ],
        ],
      ),
    );

    if (destination.tooltip != null && destination.tooltip!.isNotEmpty) {
      content = Tooltip(
        message: destination.tooltip!,
        child: content,
      );
    }

    return Semantics(
      button: true,
      selected: isSelected,
      label: semanticLabel,
      child: Material(
        color: Colors.transparent,
        borderRadius: theme.selectedItemBorderRadius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _handleTap,
          borderRadius: theme.selectedItemBorderRadius
              .resolve(Directionality.of(context)),
          splashColor: theme.selectedBackgroundColor.withOpacity(0.3),
          highlightColor: Colors.transparent,
          child: content,
        ),
      ),
    );
  }

  Widget _buildIconWithBadge(
    BuildContext context, {
    required Color targetIconColor,
    required double targetIconSize,
    required Duration duration,
    required Curve curve,
  }) {
    Widget iconWidget;

    if (destination.customIcon != null) {
      if (isSelected && destination.customSelectedIcon != null) {
        iconWidget = destination.customSelectedIcon!;
      } else {
        iconWidget = destination.customIcon!;
      }
    } else {
      final IconData currentIcon =
          (isSelected && destination.selectedIcon != null)
              ? destination.selectedIcon!
              : destination.icon!;

      iconWidget = TweenAnimationBuilder<Color?>(
        duration: duration,
        curve: curve,
        tween: ColorTween(end: targetIconColor),
        builder: (BuildContext context, Color? color, Widget? child) {
          return Icon(
            currentIcon,
            size: targetIconSize,
            color: color,
          );
        },
      );
    }

    if (destination.badge != null) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          iconWidget,
          Positioned(
            right: -destination.badge!.offset.dx,
            top: destination.badge!.offset.dy,
            child: destination.badge!.buildBadge(context),
          ),
        ],
      );
    }

    return iconWidget;
  }
}
