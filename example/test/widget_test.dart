import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('FloatingPillNavBarExampleApp renders reference design',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FloatingPillNavBarExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Chats'), findsWidgets);
    expect(find.text('Tasks'), findsWidgets);
    expect(find.text('Brain'), findsWidgets);
    expect(find.byIcon(Icons.graphic_eq), findsOneWidget);

    // Tap on Tasks
    await tester.tap(find.text('Tasks').first);
    await tester.pumpAndSettle();

    expect(find.text('Active tab index: 1'), findsOneWidget);

    // Switch to Two-Tab Demo via Chip
    await tester.tap(find.text('Two-Tab Navigation'));
    await tester.pumpAndSettle();

    expect(find.text('Discover'), findsWidgets);
    expect(find.text('Profile'), findsWidgets);
  });
}
