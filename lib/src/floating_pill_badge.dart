import 'package:flutter/material.dart';

/// Configuration for a badge displayed on a [FloatingPillDestination].
class FloatingPillBadge {
  /// Creates a badge for a navigation destination.
  const FloatingPillBadge({
    this.count,
    this.text,
    this.isDot = false,
    this.backgroundColor = const Color(0xFFFF3B30),
    this.textColor = Colors.white,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
    this.alignment = Alignment.topRight,
    this.offset = const Offset(6, -4),
    this.maxCount = 99,
    this.visible = true,
  });

  /// Factory constructor to create a small dot badge.
  const FloatingPillBadge.dot({
    Color backgroundColor = const Color(0xFFFF3B30),
    AlignmentGeometry alignment = Alignment.topRight,
    Offset offset = const Offset(4, -2),
    bool visible = true,
  }) : this(
          isDot: true,
          backgroundColor: backgroundColor,
          alignment: alignment,
          offset: offset,
          visible: visible,
        );

  /// Factory constructor to create a numerical counter badge.
  const FloatingPillBadge.count(
    int count, {
    Color backgroundColor = const Color(0xFFFF3B30),
    Color textColor = Colors.white,
    TextStyle? textStyle,
    AlignmentGeometry alignment = Alignment.topRight,
    Offset offset = const Offset(6, -4),
    int maxCount = 99,
    bool visible = true,
  }) : this(
          count: count,
          backgroundColor: backgroundColor,
          textColor: textColor,
          textStyle: textStyle,
          alignment: alignment,
          offset: offset,
          maxCount: maxCount,
          visible: visible,
        );

  /// Numeric count displayed in the badge.
  final int? count;

  /// Custom text displayed in the badge instead of a numeric count.
  final String? text;

  /// Whether the badge should display only as a small dot.
  final bool isDot;

  /// Background color of the badge.
  final Color backgroundColor;

  /// Text color inside the badge.
  final Color textColor;

  /// Custom text style for the badge label.
  final TextStyle? textStyle;

  /// Inner padding of the badge.
  final EdgeInsetsGeometry padding;

  /// Alignment of the badge relative to the icon.
  final AlignmentGeometry alignment;

  /// Translation offset applied to the badge.
  final Offset offset;

  /// Maximum count before appending `+` (e.g. 99+).
  final int maxCount;

  /// Whether the badge is currently visible.
  final bool visible;

  /// Formatted badge text label.
  String? get formattedText {
    if (isDot) return null;
    if (text != null) return text;
    if (count != null) {
      if (count! > maxCount) return '$maxCount+';
      return count.toString();
    }
    return null;
  }

  /// Builds the badge widget.
  Widget buildBadge(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    if (isDot) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
      );
    }

    final String? label = formattedText;
    if (label == null || label.isEmpty) {
      return const SizedBox.shrink();
    }

    final TextStyle defaultStyle = TextStyle(
      color: textColor,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      height: 1.1,
    );

    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: textStyle ?? defaultStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
