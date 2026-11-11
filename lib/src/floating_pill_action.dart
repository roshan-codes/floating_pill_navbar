import 'package:flutter/material.dart';

/// Configuration for the circular floating action button placed adjacent
/// to the pill navigation container.
class FloatingPillAction {
  /// Creates a floating pill action button.
  const FloatingPillAction({
    this.icon,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size,
    this.iconSize,
    this.tooltip,
    this.visible = true,
    this.elevation,
    this.shadowColor,
    this.boxShadow,
    this.enablePressAnimation = true,
    this.shape,
    this.heroTag,
  }) : assert(
          icon != null || child != null,
          'Either icon or child must be provided for FloatingPillAction.',
        );

  /// Icon displayed inside the circular action button.
  final IconData? icon;

  /// Custom widget displayed inside the action button.
  ///
  /// Takes precedence over [icon].
  final Widget? child;

  /// Callback executed when the button is pressed.
  final VoidCallback? onPressed;

  /// Background color of the action button.
  ///
  /// Defaults to black ([Colors.black]) in the default theme.
  final Color? backgroundColor;

  /// Foreground/icon color inside the action button.
  ///
  /// Defaults to white ([Colors.white]).
  final Color? foregroundColor;

  /// Diameter of the circular button.
  ///
  /// Defaults to 56.0.
  final double? size;

  /// Size of the icon displayed inside the button.
  ///
  /// Defaults to 26.0.
  final double? iconSize;

  /// Tooltip message displayed on hover or long press.
  final String? tooltip;

  /// Whether the action button is visible.
  ///
  /// Defaults to true.
  final bool visible;

  /// Elevation shadow depth of the action button.
  final double? elevation;

  /// Color of the elevation shadow.
  final Color? shadowColor;

  /// Custom box shadow list.
  final List<BoxShadow>? boxShadow;

  /// Whether to perform a subtle scale-down spring effect on press.
  ///
  /// Defaults to true.
  final bool enablePressAnimation;

  /// Custom shape border for the action button.
  ///
  /// Defaults to [CircleBorder].
  final ShapeBorder? shape;

  /// Optional Hero tag for screen transitions.
  final Object? heroTag;
}
