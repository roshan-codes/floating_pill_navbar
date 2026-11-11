import 'package:flutter/material.dart';
import 'floating_pill_action.dart';
import 'floating_pill_destination.dart';
import 'floating_pill_theme.dart';
import 'widgets/action_button.dart';
import 'widgets/navigation_container.dart';

/// A floating, pill-shaped bottom navigation bar with a separate circular
/// floating action button.
///
/// Designed with a minimal, premium iOS-inspired aesthetic with soft shadows
/// and smooth animations.
class FloatingPillNavBar extends StatelessWidget {
  /// Creates a floating pill navigation bar.
  const FloatingPillNavBar({
    super.key,
    required this.selectedIndex,
    required this.destinations,
    this.onDestinationSelected,
    this.actionButton,
    this.backgroundColor,
    this.height,
    this.borderRadius,
    this.padding,
    this.margin,
    this.elevation,
    this.shadowColor,
    this.boxShadow,
    this.border,
    this.selectedBackgroundColor,
    this.selectedIconColor,
    this.selectedLabelColor,
    this.selectedIconSize,
    this.selectedFontSize,
    this.selectedFontWeight,
    this.selectedItemPadding,
    this.selectedItemBorderRadius,
    this.unselectedIconColor,
    this.unselectedLabelColor,
    this.unselectedIconSize,
    this.unselectedFontSize,
    this.unselectedFontWeight,
    this.actionButtonGap,
    this.animationDuration,
    this.animationCurve,
    this.enableAnimation,
    this.showLabels,
    this.enableHapticFeedback,
    this.itemSpacing,
    this.useSafeArea = true,
  })  : assert(
          destinations.length >= 1,
          'At least one destination must be provided.',
        ),
        assert(
          selectedIndex >= 0 && selectedIndex < destinations.length,
          'selectedIndex must be between 0 and destinations.length - 1.',
        );

  /// Index of the currently active destination.
  final int selectedIndex;

  /// The list of navigation destinations.
  final List<FloatingPillDestination> destinations;

  /// Callback called whenever a destination item is tapped.
  final ValueChanged<int>? onDestinationSelected;

  /// Optional circular floating action button displayed next to the pill container.
  final FloatingPillAction? actionButton;

  /// Background color of the pill navigation container.
  final Color? backgroundColor;

  /// Height of the pill navigation container.
  final double? height;

  /// Border radius of the pill navigation container.
  final BorderRadiusGeometry? borderRadius;

  /// Inner padding of the pill navigation container.
  final EdgeInsetsGeometry? padding;

  /// Outer margin surrounding the navigation bar.
  final EdgeInsetsGeometry? margin;

  /// Elevation depth of the navigation container.
  final double? elevation;

  /// Shadow color of the navigation container.
  final Color? shadowColor;

  /// Custom box shadow list for the navigation container.
  final List<BoxShadow>? boxShadow;

  /// Optional border around the navigation container.
  final BoxBorder? border;

  /// Background color of the selected navigation item capsule.
  final Color? selectedBackgroundColor;

  /// Icon color for the selected navigation item.
  final Color? selectedIconColor;

  /// Label color for the selected navigation item.
  final Color? selectedLabelColor;

  /// Icon size for the selected navigation item.
  final double? selectedIconSize;

  /// Font size for the selected navigation item label.
  final double? selectedFontSize;

  /// Font weight for the selected navigation item label.
  final FontWeight? selectedFontWeight;

  /// Internal padding for the selected navigation item capsule.
  final EdgeInsetsGeometry? selectedItemPadding;

  /// Border radius for the selected navigation item capsule.
  final BorderRadiusGeometry? selectedItemBorderRadius;

  /// Icon color for unselected navigation items.
  final Color? unselectedIconColor;

  /// Label color for unselected navigation items.
  final Color? unselectedLabelColor;

  /// Icon size for unselected navigation items.
  final double? unselectedIconSize;

  /// Font size for unselected navigation items label.
  final double? unselectedFontSize;

  /// Font weight for unselected navigation items label.
  final FontWeight? unselectedFontWeight;

  /// Spacing gap between the pill container and the action button.
  final double? actionButtonGap;

  /// Duration of the item selection animation.
  final Duration? animationDuration;

  /// Curve of the item selection animation.
  final Curve? animationCurve;

  /// Whether selection animations are enabled.
  final bool? enableAnimation;

  /// Whether labels are visible across navigation items.
  final bool? showLabels;

  /// Whether haptic feedback is triggered on item selection.
  final bool? enableHapticFeedback;

  /// Spacing between navigation items inside the pill.
  final double? itemSpacing;

  /// Whether to wrap the navigation bar inside a [SafeArea].
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final FloatingPillThemeData themeFromContext =
        FloatingPillTheme.of(context);

    final FloatingPillThemeData effectiveTheme = themeFromContext.copyWith(
      backgroundColor: backgroundColor,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      elevation: elevation,
      shadowColor: shadowColor,
      boxShadow: boxShadow,
      border: border,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedIconColor: selectedIconColor,
      selectedLabelColor: selectedLabelColor,
      selectedIconSize: selectedIconSize,
      selectedFontSize: selectedFontSize,
      selectedFontWeight: selectedFontWeight,
      selectedItemPadding: selectedItemPadding,
      selectedItemBorderRadius: selectedItemBorderRadius,
      unselectedIconColor: unselectedIconColor,
      unselectedLabelColor: unselectedLabelColor,
      unselectedIconSize: unselectedIconSize,
      unselectedFontSize: unselectedFontSize,
      unselectedFontWeight: unselectedFontWeight,
      actionButtonGap: actionButtonGap,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      enableAnimation: enableAnimation,
      showLabels: showLabels,
      enableHapticFeedback: enableHapticFeedback,
      itemSpacing: itemSpacing,
    );

    // Ensure safe index clamping in release mode
    final int safeIndex = selectedIndex.clamp(0, destinations.length - 1);

    final bool hasVisibleAction = actionButton != null && actionButton!.visible;

    final Widget barContent = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: NavigationContainerWidget(
            destinations: destinations,
            selectedIndex: safeIndex,
            onDestinationSelected: (int index) {
              onDestinationSelected?.call(index);
            },
            theme: effectiveTheme,
            showLabels: showLabels,
          ),
        ),
        if (hasVisibleAction) ...<Widget>[
          SizedBox(width: effectiveTheme.actionButtonGap),
          ActionButtonWidget(
            action: actionButton!,
            theme: effectiveTheme,
          ),
        ],
      ],
    );

    final Widget paddedContent = Padding(
      padding: effectiveTheme.margin,
      child: barContent,
    );

    if (useSafeArea) {
      return SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: paddedContent,
      );
    }

    return paddedContent;
  }
}
