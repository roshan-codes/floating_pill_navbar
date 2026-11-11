import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_pill_navbar/floating_pill_navbar.dart';

void main() {
  group('FloatingPillNavBar Animation Tests', () {
    testWidgets('animates selection highlight on tab change',
        (WidgetTester tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return FloatingPillNavBar(
                  selectedIndex: selectedIndex,
                  animationDuration: const Duration(milliseconds: 300),
                  animationCurve: Curves.easeInOut,
                  onDestinationSelected: (int index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const <FloatingPillDestination>[
                    FloatingPillDestination(
                      icon: Icons.chat_bubble,
                      label: 'Chats',
                    ),
                    FloatingPillDestination(
                      icon: Icons.checklist,
                      label: 'Tasks',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially index 0 selected
      final AnimatedContainer container0Before =
          tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(FloatingPillNavBar),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      final BoxDecoration decoration0Before =
          container0Before.decoration as BoxDecoration;
      expect(decoration0Before.color, const Color(0xFFF1F1F4));

      // Tap on Tasks
      await tester.tap(find.text('Tasks'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 150)); // Mid animation
      await tester.pumpAndSettle(); // End animation

      expect(selectedIndex, 1);
    });

    testWidgets('disables animation when enableAnimation is false',
        (WidgetTester tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return FloatingPillNavBar(
                  selectedIndex: selectedIndex,
                  enableAnimation: false,
                  onDestinationSelected: (int index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const <FloatingPillDestination>[
                    FloatingPillDestination(icon: Icons.home, label: 'Home'),
                    FloatingPillDestination(icon: Icons.star, label: 'Star'),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Star'));
      // Since enableAnimation is false, no ticks needed
      await tester.pump();
      expect(selectedIndex, 1);
    });

    testWidgets('action button performs press scale animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.home, label: 'Home'),
                FloatingPillDestination(icon: Icons.work, label: 'Work'),
              ],
              actionButton: FloatingPillAction(
                icon: Icons.add,
                enablePressAnimation: true,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      final Finder actionFinder = find.byIcon(Icons.add);
      expect(actionFinder, findsOneWidget);

      final Offset center = tester.getCenter(actionFinder);
      final TestGesture gesture = await tester.startGesture(center);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      final Transform transform = tester.widget<Transform>(
        find.byKey(const ValueKey<String>('action_button_scale_transform')),
      );
      expect(transform.transform.entry(0, 0), lessThan(1.0));

      await gesture.up();
      await tester.pumpAndSettle();
    });
  });
}
