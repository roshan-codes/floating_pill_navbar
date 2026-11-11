import 'package:flutter/widgets.dart';
import 'floating_pill_badge.dart';

/// A destination item represented within the [FloatingPillNavBar].
class FloatingPillDestination {
  /// Creates a navigation destination for [FloatingPillNavBar].
  const FloatingPillDestination({
    this.icon,
    this.selectedIcon,
    this.customIcon,
    this.customSelectedIcon,
    this.label,
    this.showLabel,
    this.badge,
    this.tooltip,
    this.key,
  }) : assert(
          icon != null || customIcon != null,
          'Either icon or customIcon must be provided.',
        );

  /// Icon data used when the destination is unselected.
  final IconData? icon;

  /// Optional icon data used when the destination is selected.
  ///
  /// If null, [icon] will be used for both states.
  final IconData? selectedIcon;

  /// Custom widget for the icon when unselected.
  ///
  /// Takes precedence over [icon].
  final Widget? customIcon;

  /// Custom widget for the icon when selected.
  ///
  /// Takes precedence over [selectedIcon].
  final Widget? customSelectedIcon;

  /// Text label displayed beneath or beside the icon.
  final String? label;

  /// Optional flag to explicitly show or hide the label for this item.
  ///
  /// If null, falls back to the navbar or theme configuration.
  final bool? showLabel;

  /// Optional badge rendered on the destination.
  final FloatingPillBadge? badge;

  /// Optional tooltip text displayed on long press or mouse hover.
  final String? tooltip;

  /// Key for the destination widget.
  final Key? key;
}
