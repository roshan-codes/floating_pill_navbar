# floating_pill_navbar

[![pub package](https://img.shields.io/pub/v/floating_pill_navbar.svg)](https://pub.dev/packages/floating_pill_navbar)
[![pub points](https://img.shields.io/pub/points/floating_pill_navbar)](https://pub.dev/packages/floating_pill_navbar/score)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/roshan-codes/floating_pill_navbar/blob/main/LICENSE)

A customizable floating pill-shaped bottom navigation bar with a companion circular action button for Flutter.

Inspired by modern, minimal iOS design patterns with soft shadows, capsule selection highlights, and smooth micro-interactions.

---

## Features

- **Pill Container**: Capsule corners, soft drop shadows, and automatic item width distribution.
- **Detached Action Button**: Circular action button with tactile scale animation on press.
- **Smooth Animations**: Animated selection highlight with icon and label color transitions.
- **Dynamic Items**: Cleanly supports 2, 3, 4, 5 or more destinations.
- **Badges**: Numerical counters, notification dots, and configurable count caps (e.g., `99+`).
- **Flexible Theming**: Granular styling with `FloatingPillTheme` and `FloatingPillThemeData.dark()`.
- **Zero Third-Party Dependencies**: Pure Flutter implementation.
- **Accessible & Responsive**: Supports RTL, SafeArea, semantics, small screens, and tablets.

---

## Getting Started

Add `floating_pill_navbar` to your `pubspec.yaml`:

```yaml
dependencies:
  floating_pill_navbar: ^1.0.0
```

Import the package:

```dart
import 'package:floating_pill_navbar/floating_pill_navbar.dart';
```

---

## Quick Example

```dart
int _selectedIndex = 0;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _pages[_selectedIndex],
    bottomNavigationBar: FloatingPillNavBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      destinations: const [
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
        tooltip: 'Voice command',
        onPressed: () {
          // Action button tapped
        },
      ),
    ),
  );
}
```

---

## Customization Examples

### With Badges

```dart
FloatingPillNavBar(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (i) => setState(() => _selectedIndex = i),
  destinations: const [
    FloatingPillDestination(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      label: 'Chats',
      badge: FloatingPillBadge.count(5),
    ),
    FloatingPillDestination(
      icon: Icons.notifications_none,
      selectedIcon: Icons.notifications,
      label: 'Alerts',
      badge: FloatingPillBadge.dot(),
    ),
  ],
)
```

### Dark Mode

```dart
FloatingPillNavBar(
  selectedIndex: _selectedIndex,
  backgroundColor: const Color(0xFF1C1C1E),
  selectedBackgroundColor: const Color(0xFF2C2C2E),
  selectedIconColor: Colors.white,
  selectedLabelColor: Colors.white,
  unselectedIconColor: const Color(0xFF8E8E93),
  unselectedLabelColor: const Color(0xFF8E8E93),
  onDestinationSelected: (i) => setState(() => _selectedIndex = i),
  destinations: _destinations,
  actionButton: FloatingPillAction(
    icon: Icons.graphic_eq,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    onPressed: () {},
  ),
)
```

### Without Action Button

```dart
FloatingPillNavBar(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (i) => setState(() => _selectedIndex = i),
  destinations: _destinations,
)
```

---

## API Reference

### FloatingPillNavBar

| Property | Type | Default | Description |
|---|---|---|---|
| `selectedIndex` | `int` | *required* | Current active tab index |
| `destinations` | `List<FloatingPillDestination>` | *required* | Navigation items |
| `onDestinationSelected` | `ValueChanged<int>?` | `null` | Item tap callback |
| `actionButton` | `FloatingPillAction?` | `null` | Companion circular action button |
| `backgroundColor` | `Color?` | `Colors.white` | Navigation container background |
| `height` | `double?` | `64.0` | Navigation container height |
| `borderRadius` | `BorderRadiusGeometry?` | `BorderRadius.circular(32)` | Container corner radius |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.only(left: 16, right: 16, bottom: 24)` | Outer margin |
| `selectedBackgroundColor` | `Color?` | `Color(0xFFF1F1F4)` | Active item highlight capsule color |
| `selectedIconColor` | `Color?` | `Color(0xFF111111)` | Active icon color |
| `unselectedIconColor` | `Color?` | `Color(0xFF757579)` | Inactive icon color |
| `animationDuration` | `Duration?` | `Duration(milliseconds: 250)` | Transition duration |
| `animationCurve` | `Curve?` | `Curves.easeInOut` | Transition curve |
| `useSafeArea` | `bool` | `true` | Wraps inside bottom SafeArea |

---

## License

MIT License. See [LICENSE](LICENSE) for details.

