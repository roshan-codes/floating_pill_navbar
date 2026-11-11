import 'package:flutter/material.dart';
import '../floating_pill_action.dart';
import '../floating_pill_theme.dart';

/// The separate circular floating action button rendered alongside
/// the navigation container.
class ActionButtonWidget extends StatefulWidget {
  /// Creates an action button widget.
  const ActionButtonWidget({
    super.key,
    required this.action,
    required this.theme,
  });

  /// Action configuration.
  final FloatingPillAction action;

  /// Active theme data.
  final FloatingPillThemeData theme;

  @override
  State<ActionButtonWidget> createState() => _ActionButtonWidgetState();
}

class _ActionButtonWidgetState extends State<ActionButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (widget.action.enablePressAnimation) {
      _scaleController.forward();
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (widget.action.enablePressAnimation) {
      _scaleController.reverse();
    }
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    if (widget.action.enablePressAnimation) {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.action.visible) {
      return const SizedBox.shrink();
    }

    final double size = widget.action.size ?? widget.theme.actionSize;
    final Color backgroundColor =
        widget.action.backgroundColor ?? widget.theme.actionBackgroundColor;
    final Color foregroundColor =
        widget.action.foregroundColor ?? widget.theme.actionForegroundColor;
    final double iconSize =
        widget.action.iconSize ?? widget.theme.actionIconSize;

    final List<BoxShadow> shadows = widget.action.boxShadow ??
        widget.theme.actionBoxShadow ??
        <BoxShadow>[
          BoxShadow(
            color: widget.action.shadowColor ?? widget.theme.actionShadowColor,
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ];

    Widget buttonChild;
    if (widget.action.child != null) {
      buttonChild = widget.action.child!;
    } else if (widget.action.icon != null) {
      buttonChild = Icon(
        widget.action.icon,
        size: iconSize,
        color: foregroundColor,
      );
    } else {
      buttonChild = const SizedBox.shrink();
    }

    Widget content = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          key: const ValueKey<String>('action_button_scale_transform'),
          scale:
              widget.action.enablePressAnimation ? _scaleAnimation.value : 1.0,
          child: child,
        );
      },
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: _handlePointerDown,
        onPointerUp: _handlePointerUp,
        onPointerCancel: _handlePointerCancel,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.action.onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: shadows,
            ),
            child: Center(
              child: buttonChild,
            ),
          ),
        ),
      ),
    );

    if (widget.action.tooltip != null && widget.action.tooltip!.isNotEmpty) {
      content = Tooltip(
        message: widget.action.tooltip!,
        child: content,
      );
    }

    if (widget.action.heroTag != null) {
      content = Hero(
        tag: widget.action.heroTag!,
        child: content,
      );
    }

    return Semantics(
      button: true,
      label: widget.action.tooltip ?? 'Action',
      child: content,
    );
  }
}
