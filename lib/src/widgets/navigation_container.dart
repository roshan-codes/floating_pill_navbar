import 'package:flutter/material.dart';
import '../floating_pill_destination.dart';
import '../floating_pill_theme.dart';
import 'navigation_item.dart';

/// The pill-shaped container that houses the navigation destination items.
class NavigationContainerWidget extends StatelessWidget {
  /// Creates the navigation container.
  const NavigationContainerWidget({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.theme,
    this.showLabels,
  });

  /// The list of destinations to render.
  final List<FloatingPillDestination> destinations;

  /// The currently active index.
  final int selectedIndex;

  /// Callback when a destination item is tapped.
  final ValueChanged<int> onDestinationSelected;

  /// The active theme data.
  final FloatingPillThemeData theme;

  /// Optional override for label visibility.
  final bool? showLabels;

  @override
  Widget build(BuildContext context) {
    final List<BoxShadow> shadows = theme.boxShadow ??
        <BoxShadow>[
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 18.0,
            offset: const Offset(0, 4),
          ),
        ];

    return Container(
      height: theme.height,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius,
        border: theme.border,
        boxShadow: shadows,
      ),
      padding: theme.padding,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final int count = destinations.length;
          if (count == 0) return const SizedBox.shrink();

          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(count, (int index) {
              final FloatingPillDestination destination = destinations[index];
              final bool isSelected = index == selectedIndex;

              return Expanded(
                key: destination.key,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.itemSpacing / 2,
                  ),
                  child: NavigationItemWidget(
                    destination: destination,
                    isSelected: isSelected,
                    onTap: () => onDestinationSelected(index),
                    theme: theme,
                    showLabel: showLabels,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

