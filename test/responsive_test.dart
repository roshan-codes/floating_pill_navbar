import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_pill_navbar/floating_pill_navbar.dart';

void main() {
  group('FloatingPillNavBar Responsive & Layout Tests', () {
    testWidgets(
        'renders on small mobile screens (320px width) without overflow',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(320 * 2.0, 568 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(
                  icon: Icons.chat_bubble,
                  label: 'Chats',
                ),
                FloatingPillDestination(
                  icon: Icons.checklist,
                  label: 'Tasks',
                ),
                FloatingPillDestination(
                  icon: Icons.psychology,
                  label: 'Brain',
                ),
              ],
              actionButton: FloatingPillAction(
                icon: Icons.graphic_eq,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Chats'), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('Brain'), findsOneWidget);
      expect(find.byIcon(Icons.graphic_eq), findsOneWidget);
    });

    testWidgets('renders on large tablet/desktop screens (1024px width)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1024 * 2.0, 768 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.home, label: 'Home'),
                FloatingPillDestination(icon: Icons.search, label: 'Search'),
                FloatingPillDestination(icon: Icons.person, label: 'Profile'),
              ],
              actionButton: FloatingPillAction(
                icon: Icons.mic,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsOneWidget);
    });

    testWidgets('renders dynamically with 2, 4, and 5 destinations',
        (WidgetTester tester) async {
      final List<List<FloatingPillDestination>> destinationSets =
          <List<FloatingPillDestination>>[
        // 2 items
        const <FloatingPillDestination>[
          FloatingPillDestination(icon: Icons.home, label: 'Home'),
          FloatingPillDestination(icon: Icons.settings, label: 'Settings'),
        ],
        // 4 items
        const <FloatingPillDestination>[
          FloatingPillDestination(icon: Icons.chat, label: 'Chats'),
          FloatingPillDestination(icon: Icons.call, label: 'Calls'),
          FloatingPillDestination(icon: Icons.star, label: 'Favorites'),
          FloatingPillDestination(icon: Icons.person, label: 'Profile'),
        ],
        // 5 items
        const <FloatingPillDestination>[
          FloatingPillDestination(icon: Icons.explore, label: 'Explore'),
          FloatingPillDestination(icon: Icons.bookmark, label: 'Saved'),
          FloatingPillDestination(icon: Icons.notifications, label: 'Alerts'),
          FloatingPillDestination(icon: Icons.mail, label: 'Mail'),
          FloatingPillDestination(icon: Icons.person, label: 'Account'),
        ],
      ];

      for (final List<FloatingPillDestination> list in destinationSets) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: FloatingPillNavBar(
                selectedIndex: 0,
                onDestinationSelected: (_) {},
                destinations: list,
                actionButton: FloatingPillAction(
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        for (final FloatingPillDestination dest in list) {
          expect(find.text(dest.label!), findsOneWidget);
        }
      }
    });

    testWidgets('respects SafeArea and bottom padding',
        (WidgetTester tester) async {
      tester.view.padding = const FakeViewPadding(bottom: 34.0);
      addTearDown(() {
        tester.view.resetPadding();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              useSafeArea: true,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.home, label: 'Home'),
                FloatingPillDestination(icon: Icons.person, label: 'Profile'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('landscape orientation renders without overflow',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(844 * 2.0, 390 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 1,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.chat, label: 'Chats'),
                FloatingPillDestination(icon: Icons.task, label: 'Tasks'),
                FloatingPillDestination(icon: Icons.psychology, label: 'Brain'),
              ],
              actionButton: FloatingPillAction(
                icon: Icons.mic,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Tasks'), findsOneWidget);
    });
  });
}
