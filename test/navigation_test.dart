import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floating_pill_navbar/floating_pill_navbar.dart';

void main() {
  group('FloatingPillNavBar Navigation & Callbacks', () {
    testWidgets('renders all destinations and shows correct selected item',
        (WidgetTester tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return FloatingPillNavBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const <FloatingPillDestination>[
                    FloatingPillDestination(
                      icon: Icons.chat_bubble_outline,
                      selectedIcon: Icons.chat_bubble,
                      label: 'Chats',
                    ),
                    FloatingPillDestination(
                      icon: Icons.checklist_outlined,
                      selectedIcon: Icons.checklist,
                      label: 'Tasks',
                    ),
                    FloatingPillDestination(
                      icon: Icons.psychology_outlined,
                      selectedIcon: Icons.psychology,
                      label: 'Brain',
                    ),
                  ],
                  actionButton: FloatingPillAction(
                    icon: Icons.graphic_eq,
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Verify labels are displayed
      expect(find.text('Chats'), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('Brain'), findsOneWidget);

      // Tap on Tasks (index 1)
      await tester.tap(find.text('Tasks'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('triggers action button callback when tapped',
        (WidgetTester tester) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.home, label: 'Home'),
                FloatingPillDestination(
                    icon: Icons.settings, label: 'Settings'),
              ],
              actionButton: FloatingPillAction(
                icon: Icons.add,
                onPressed: () {
                  actionPressed = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(actionPressed, isTrue);
    });

    testWidgets('does not render action button when visible is false or null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(icon: Icons.home, label: 'Home'),
                FloatingPillDestination(icon: Icons.search, label: 'Search'),
              ],
              actionButton: const FloatingPillAction(
                icon: Icons.add,
                visible: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('renders badges accurately (count, dot, maxCount overflow)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(
                  icon: Icons.chat,
                  label: 'Chats',
                  badge: FloatingPillBadge.count(5),
                ),
                FloatingPillDestination(
                  icon: Icons.notifications,
                  label: 'Alerts',
                  badge: FloatingPillBadge.dot(),
                ),
                FloatingPillDestination(
                  icon: Icons.mail,
                  label: 'Inbox',
                  badge: FloatingPillBadge.count(150, maxCount: 99),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('supports RTL layout seamlessly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              bottomNavigationBar: FloatingPillNavBar(
                selectedIndex: 0,
                onDestinationSelected: (_) {},
                destinations: const <FloatingPillDestination>[
                  FloatingPillDestination(icon: Icons.chat, label: 'محادثة'),
                  FloatingPillDestination(icon: Icons.person, label: 'حساب'),
                ],
                actionButton: FloatingPillAction(
                  icon: Icons.mic,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('محادثة'), findsOneWidget);
      expect(find.text('حساب'), findsOneWidget);
      expect(find.byIcon(Icons.mic), findsOneWidget);
    });

    testWidgets('supports custom widgets for icons and action button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: FloatingPillNavBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const <FloatingPillDestination>[
                FloatingPillDestination(
                  customIcon: Text('Custom1'),
                  customSelectedIcon: Text('Custom1Selected'),
                  label: 'Custom',
                ),
                FloatingPillDestination(
                  icon: Icons.star,
                  label: 'Star',
                ),
              ],
              actionButton: const FloatingPillAction(
                child: Text('ActionCustom'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom1Selected'), findsOneWidget);
      expect(find.text('ActionCustom'), findsOneWidget);
    });

    testWidgets('asserts on invalid selected index in debug mode',
        (WidgetTester tester) async {
      expect(
        () => FloatingPillNavBar(
          selectedIndex: 5,
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(icon: Icons.home, label: 'Home'),
            FloatingPillDestination(icon: Icons.search, label: 'Search'),
          ],
        ),
        throwsAssertionError,
      );
    });
  });
}
