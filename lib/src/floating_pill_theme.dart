import 'dart:ui';
import 'package:flutter/material.dart';

/// Defines the visual styling and animation parameters for [FloatingPillNavBar].
@immutable
class FloatingPillThemeData {
  /// Creates a theme configuration for [FloatingPillNavBar].
  const FloatingPillThemeData({
    this.backgroundColor = Colors.white,
    this.height = 64.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(32.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    this.margin = const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
    this.elevation = 0.0,
    this.shadowColor = const Color(0x14000000),
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x12000000),
        blurRadius: 18.0,
        spreadRadius: 0.0,
        offset: Offset(0, 4),
      ),
    ],
    this.border,
    this.selectedBackgroundColor = const Color(0xFFF1F1F4),
    this.selectedIconColor = const Color(0xFF111111),
    this.selectedLabelColor = const Color(0xFF111111),
    this.selectedIconSize = 22.0,
    this.selectedFontSize = 11.5,
    this.selectedFontWeight = FontWeight.w600,
    this.selectedItemPadding =
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    this.selectedItemBorderRadius =
        const BorderRadius.all(Radius.circular(24.0)),
    this.unselectedIconColor = const Color(0xFF757579),
    this.unselectedLabelColor = const Color(0xFF757579),
    this.unselectedIconSize = 22.0,
    this.unselectedFontSize = 11.5,
    this.unselectedFontWeight = FontWeight.w500,
    this.actionBackgroundColor = const Color(0xFF111111),
    this.actionForegroundColor = Colors.white,
    this.actionSize = 56.0,
    this.actionIconSize = 24.0,
    this.actionButtonGap = 12.0,
    this.actionElevation = 0.0,
    this.actionShadowColor = const Color(0x20000000),
    this.actionBoxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x1F000000),
        blurRadius: 16.0,
        spreadRadius: 0.0,
        offset: Offset(0, 4),
      ),
    ],
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOut,
    this.enableAnimation = true,
    this.showLabels = true,
    this.enableHapticFeedback = true,
    this.itemSpacing = 4.0,
  });

  /// Factory constructor for a refined dark theme appearance.
  factory FloatingPillThemeData.dark({
    Color backgroundColor = const Color(0xFF1C1C1E),
    Color selectedBackgroundColor = const Color(0xFF2C2C2E),
    Color selectedIconColor = Colors.white,
    Color selectedLabelColor = Colors.white,
    Color unselectedIconColor = const Color(0xFF8E8E93),
    Color unselectedLabelColor = const Color(0xFF8E8E93),
    Color actionBackgroundColor = Colors.white,
    Color actionForegroundColor = Colors.black,
    List<BoxShadow> boxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 20.0,
        spreadRadius: 0.0,
        offset: Offset(0, 4),
      ),
    ],
    List<BoxShadow> actionBoxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color(0x35000000),
        blurRadius: 18.0,
        spreadRadius: 0.0,
        offset: Offset(0, 4),
      ),
    ],
    double height = 64.0,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(32.0)),
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    EdgeInsetsGeometry margin =
        const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
    BoxBorder? border,
  }) {
    return FloatingPillThemeData(
      backgroundColor: backgroundColor,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      boxShadow: boxShadow,
      border: border,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedIconColor: selectedIconColor,
      selectedLabelColor: selectedLabelColor,
      unselectedIconColor: unselectedIconColor,
      unselectedLabelColor: unselectedLabelColor,
      actionBackgroundColor: actionBackgroundColor,
      actionForegroundColor: actionForegroundColor,
      actionBoxShadow: actionBoxShadow,
    );
  }

  /// Navigation container background color.
  final Color backgroundColor;

  /// Navigation container height.
  final double height;

  /// Navigation container border radius.
  final BorderRadiusGeometry borderRadius;

  /// Internal padding for the navigation container.
  final EdgeInsetsGeometry padding;

  /// Outer margin surrounding the navigation bar.
  final EdgeInsetsGeometry margin;

  /// Elevation depth of the navigation container.
  final double elevation;

  /// Shadow color of the navigation container.
  final Color shadowColor;

  /// Custom box shadow list for the navigation container.
  final List<BoxShadow>? boxShadow;

  /// Optional border applied to the navigation container.
  final BoxBorder? border;

  /// Background color of the selected navigation item capsule.
  final Color selectedBackgroundColor;

  /// Icon color for the selected navigation item.
  final Color selectedIconColor;

  /// Label color for the selected navigation item.
  final Color selectedLabelColor;

  /// Icon size for the selected navigation item.
  final double selectedIconSize;

  /// Font size for the selected navigation item label.
  final double selectedFontSize;

  /// Font weight for the selected navigation item label.
  final FontWeight selectedFontWeight;

  /// Internal padding of the selected navigation item capsule.
  final EdgeInsetsGeometry selectedItemPadding;

  /// Border radius of the selected item highlight capsule.
  final BorderRadiusGeometry selectedItemBorderRadius;

  /// Icon color for unselected navigation items.
  final Color unselectedIconColor;

  /// Label color for unselected navigation items.
  final Color unselectedLabelColor;

  /// Icon size for unselected navigation items.
  final double unselectedIconSize;

  /// Font size for unselected navigation items label.
  final double unselectedFontSize;

  /// Font weight for unselected navigation items label.
  final FontWeight unselectedFontWeight;

  /// Background color of the action button.
  final Color actionBackgroundColor;

  /// Foreground/icon color of the action button.
  final Color actionForegroundColor;

  /// Diameter of the action button.
  final double actionSize;

  /// Icon size of the action button.
  final double actionIconSize;

  /// Spacing between the pill navigation container and the action button.
  final double actionButtonGap;

  /// Elevation depth of the action button.
  final double actionElevation;

  /// Shadow color of the action button.
  final Color actionShadowColor;

  /// Custom box shadow list for the action button.
  final List<BoxShadow>? actionBoxShadow;

  /// Duration of selection transition animations.
  final Duration animationDuration;

  /// Curve of selection transition animations.
  final Curve animationCurve;

  /// Whether animations are enabled.
  final bool enableAnimation;

  /// Whether labels are visible across navigation items.
  final bool showLabels;

  /// Whether to provide haptic feedback on navigation selection.
  final bool enableHapticFeedback;

  /// Horizontal spacing between navigation items inside the pill.
  final double itemSpacing;

  /// Creates a copy of this theme data with updated values.
  FloatingPillThemeData copyWith({
    Color? backgroundColor,
    double? height,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    Color? shadowColor,
    List<BoxShadow>? boxShadow,
    BoxBorder? border,
    Color? selectedBackgroundColor,
    Color? selectedIconColor,
    Color? selectedLabelColor,
    double? selectedIconSize,
    double? selectedFontSize,
    FontWeight? selectedFontWeight,
    EdgeInsetsGeometry? selectedItemPadding,
    BorderRadiusGeometry? selectedItemBorderRadius,
    Color? unselectedIconColor,
    Color? unselectedLabelColor,
    double? unselectedIconSize,
    double? unselectedFontSize,
    FontWeight? unselectedFontWeight,
    Color? actionBackgroundColor,
    Color? actionForegroundColor,
    double? actionSize,
    double? actionIconSize,
    double? actionButtonGap,
    double? actionElevation,
    Color? actionShadowColor,
    List<BoxShadow>? actionBoxShadow,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? enableAnimation,
    bool? showLabels,
    bool? enableHapticFeedback,
    double? itemSpacing,
  }) {
    return FloatingPillThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      boxShadow: boxShadow ?? this.boxShadow,
      border: border ?? this.border,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      selectedLabelColor: selectedLabelColor ?? this.selectedLabelColor,
      selectedIconSize: selectedIconSize ?? this.selectedIconSize,
      selectedFontSize: selectedFontSize ?? this.selectedFontSize,
      selectedFontWeight: selectedFontWeight ?? this.selectedFontWeight,
      selectedItemPadding: selectedItemPadding ?? this.selectedItemPadding,
      selectedItemBorderRadius:
          selectedItemBorderRadius ?? this.selectedItemBorderRadius,
      unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
      unselectedLabelColor: unselectedLabelColor ?? this.unselectedLabelColor,
      unselectedIconSize: unselectedIconSize ?? this.unselectedIconSize,
      unselectedFontSize: unselectedFontSize ?? this.unselectedFontSize,
      unselectedFontWeight: unselectedFontWeight ?? this.unselectedFontWeight,
      actionBackgroundColor:
          actionBackgroundColor ?? this.actionBackgroundColor,
      actionForegroundColor:
          actionForegroundColor ?? this.actionForegroundColor,
      actionSize: actionSize ?? this.actionSize,
      actionIconSize: actionIconSize ?? this.actionIconSize,
      actionButtonGap: actionButtonGap ?? this.actionButtonGap,
      actionElevation: actionElevation ?? this.actionElevation,
      actionShadowColor: actionShadowColor ?? this.actionShadowColor,
      actionBoxShadow: actionBoxShadow ?? this.actionBoxShadow,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      enableAnimation: enableAnimation ?? this.enableAnimation,
      showLabels: showLabels ?? this.showLabels,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      itemSpacing: itemSpacing ?? this.itemSpacing,
    );
  }

  /// Linearly interpolates between two [FloatingPillThemeData] objects.
  static FloatingPillThemeData? lerp(
    FloatingPillThemeData? a,
    FloatingPillThemeData? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    if (a == null) return b;
    if (b == null) return a;

    return FloatingPillThemeData(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t) ??
          b.backgroundColor,
      height: lerpDouble(a.height, b.height, t) ?? b.height,
      borderRadius:
          BorderRadiusGeometry.lerp(a.borderRadius, b.borderRadius, t) ??
              b.borderRadius,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? b.padding,
      margin: EdgeInsetsGeometry.lerp(a.margin, b.margin, t) ?? b.margin,
      elevation: lerpDouble(a.elevation, b.elevation, t) ?? b.elevation,
      shadowColor: Color.lerp(a.shadowColor, b.shadowColor, t) ?? b.shadowColor,
      boxShadow: BoxShadow.lerpList(a.boxShadow, b.boxShadow, t),
      border: BoxBorder.lerp(a.border, b.border, t),
      selectedBackgroundColor: Color.lerp(
            a.selectedBackgroundColor,
            b.selectedBackgroundColor,
            t,
          ) ??
          b.selectedBackgroundColor,
      selectedIconColor:
          Color.lerp(a.selectedIconColor, b.selectedIconColor, t) ??
              b.selectedIconColor,
      selectedLabelColor:
          Color.lerp(a.selectedLabelColor, b.selectedLabelColor, t) ??
              b.selectedLabelColor,
      selectedIconSize: lerpDouble(a.selectedIconSize, b.selectedIconSize, t) ??
          b.selectedIconSize,
      selectedFontSize: lerpDouble(a.selectedFontSize, b.selectedFontSize, t) ??
          b.selectedFontSize,
      selectedFontWeight:
          FontWeight.lerp(a.selectedFontWeight, b.selectedFontWeight, t) ??
              b.selectedFontWeight,
      selectedItemPadding: EdgeInsetsGeometry.lerp(
            a.selectedItemPadding,
            b.selectedItemPadding,
            t,
          ) ??
          b.selectedItemPadding,
      selectedItemBorderRadius: BorderRadiusGeometry.lerp(
            a.selectedItemBorderRadius,
            b.selectedItemBorderRadius,
            t,
          ) ??
          b.selectedItemBorderRadius,
      unselectedIconColor:
          Color.lerp(a.unselectedIconColor, b.unselectedIconColor, t) ??
              b.unselectedIconColor,
      unselectedLabelColor:
          Color.lerp(a.unselectedLabelColor, b.unselectedLabelColor, t) ??
              b.unselectedLabelColor,
      unselectedIconSize:
          lerpDouble(a.unselectedIconSize, b.unselectedIconSize, t) ??
              b.unselectedIconSize,
      unselectedFontSize:
          lerpDouble(a.unselectedFontSize, b.unselectedFontSize, t) ??
              b.unselectedFontSize,
      unselectedFontWeight: FontWeight.lerp(
            a.unselectedFontWeight,
            b.unselectedFontWeight,
            t,
          ) ??
          b.unselectedFontWeight,
      actionBackgroundColor: Color.lerp(
            a.actionBackgroundColor,
            b.actionBackgroundColor,
            t,
          ) ??
          b.actionBackgroundColor,
      actionForegroundColor: Color.lerp(
            a.actionForegroundColor,
            b.actionForegroundColor,
            t,
          ) ??
          b.actionForegroundColor,
      actionSize: lerpDouble(a.actionSize, b.actionSize, t) ?? b.actionSize,
      actionIconSize:
          lerpDouble(a.actionIconSize, b.actionIconSize, t) ?? b.actionIconSize,
      actionButtonGap: lerpDouble(a.actionButtonGap, b.actionButtonGap, t) ??
          b.actionButtonGap,
      actionElevation: lerpDouble(a.actionElevation, b.actionElevation, t) ??
          b.actionElevation,
      actionShadowColor: Color.lerp(
            a.actionShadowColor,
            b.actionShadowColor,
            t,
          ) ??
          b.actionShadowColor,
      actionBoxShadow:
          BoxShadow.lerpList(a.actionBoxShadow, b.actionBoxShadow, t),
      animationDuration: t < 0.5 ? a.animationDuration : b.animationDuration,
      animationCurve: t < 0.5 ? a.animationCurve : b.animationCurve,
      enableAnimation: t < 0.5 ? a.enableAnimation : b.enableAnimation,
      showLabels: t < 0.5 ? a.showLabels : b.showLabels,
      enableHapticFeedback:
          t < 0.5 ? a.enableHapticFeedback : b.enableHapticFeedback,
      itemSpacing: lerpDouble(a.itemSpacing, b.itemSpacing, t) ?? b.itemSpacing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FloatingPillThemeData &&
        other.backgroundColor == backgroundColor &&
        other.height == height &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.margin == margin &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.border == border &&
        other.selectedBackgroundColor == selectedBackgroundColor &&
        other.selectedIconColor == selectedIconColor &&
        other.selectedLabelColor == selectedLabelColor &&
        other.selectedIconSize == selectedIconSize &&
        other.selectedFontSize == selectedFontSize &&
        other.selectedFontWeight == selectedFontWeight &&
        other.selectedItemPadding == selectedItemPadding &&
        other.selectedItemBorderRadius == selectedItemBorderRadius &&
        other.unselectedIconColor == unselectedIconColor &&
        other.unselectedLabelColor == unselectedLabelColor &&
        other.unselectedIconSize == unselectedIconSize &&
        other.unselectedFontSize == unselectedFontSize &&
        other.unselectedFontWeight == unselectedFontWeight &&
        other.actionBackgroundColor == actionBackgroundColor &&
        other.actionForegroundColor == actionForegroundColor &&
        other.actionSize == actionSize &&
        other.actionIconSize == actionIconSize &&
        other.actionButtonGap == actionButtonGap &&
        other.actionElevation == actionElevation &&
        other.actionShadowColor == actionShadowColor &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.enableAnimation == enableAnimation &&
        other.showLabels == showLabels &&
        other.enableHapticFeedback == enableHapticFeedback &&
        other.itemSpacing == itemSpacing;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        backgroundColor,
        height,
        borderRadius,
        padding,
        margin,
        elevation,
        shadowColor,
        border,
        selectedBackgroundColor,
        selectedIconColor,
        selectedLabelColor,
        selectedIconSize,
        selectedFontSize,
        selectedFontWeight,
        selectedItemPadding,
        selectedItemBorderRadius,
        unselectedIconColor,
        unselectedLabelColor,
        unselectedIconSize,
        unselectedFontSize,
        unselectedFontWeight,
        actionBackgroundColor,
        actionForegroundColor,
        actionSize,
        actionIconSize,
        actionButtonGap,
        actionElevation,
        actionShadowColor,
        animationDuration,
        animationCurve,
        enableAnimation,
        showLabels,
        enableHapticFeedback,
        itemSpacing,
      ]);
}

/// An inherited theme that defines visual styling for descendant
/// [FloatingPillNavBar] widgets.
class FloatingPillTheme extends InheritedTheme {
  /// Applies the given [data] to child widgets.
  const FloatingPillTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The properties used to configure descendant [FloatingPillNavBar]s.
  final FloatingPillThemeData data;

  /// Returns the nearest [FloatingPillThemeData] ancestor or a default instance.
  static FloatingPillThemeData of(BuildContext context) {
    final FloatingPillTheme? theme =
        context.dependOnInheritedWidgetOfExactType<FloatingPillTheme>();
    return theme?.data ?? const FloatingPillThemeData();
  }

  @override
  bool updateShouldNotify(FloatingPillTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FloatingPillTheme(data: data, child: child);
  }
}
