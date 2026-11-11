import 'package:flutter/material.dart';
import 'package:floating_pill_navbar/floating_pill_navbar.dart';

void main() {
  runApp(const FloatingPillNavBarExampleApp());
}

/// Main example application demonstrating different configurations
/// of [FloatingPillNavBar].
class FloatingPillNavBarExampleApp extends StatefulWidget {
  /// Creates the example application.
  const FloatingPillNavBarExampleApp({super.key});

  @override
  State<FloatingPillNavBarExampleApp> createState() =>
      _FloatingPillNavBarExampleAppState();
}

class _FloatingPillNavBarExampleAppState
    extends State<FloatingPillNavBarExampleApp> {
  int _currentDemoIndex = 0;
  bool _isDarkMode = false;

  final List<String> _demoTitles = <String>[
    '1. Reference Design (3 Tabs)',
    '2. Two-Tab Navigation',
    '3. Four-Tab Navigation',
    '4. Without Action Button',
    '5. Custom Colors',
    '6. Custom Icons',
    '7. Badges & Counts',
    '8. Custom Animation',
    '9. Dark Theme',
    '10. Custom Action Button',
  ];

  @override
  Widget build(BuildContext context) {
    final bool useDarkTheme = _isDarkMode || _currentDemoIndex == 8;

    return MaterialApp(
      title: 'Floating Pill NavBar Showcase',
      debugShowCheckedModeBanner: false,
      themeMode: useDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F7F9),
        colorSchemeSeed: Colors.black,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121214),
        colorSchemeSeed: Colors.white,
      ),
      home: _DemoScaffold(
        demoIndex: _currentDemoIndex,
        demoTitles: _demoTitles,
        onSelectDemo: (int index) {
          setState(() {
            _currentDemoIndex = index;
            if (index == 8) {
              _isDarkMode = true;
            } else if (_isDarkMode && index != 8) {
              _isDarkMode = false;
            }
          });
        },
        isDarkMode: useDarkTheme,
        onToggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}

class _DemoScaffold extends StatefulWidget {
  const _DemoScaffold({
    required this.demoIndex,
    required this.demoTitles,
    required this.onSelectDemo,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final int demoIndex;
  final List<String> demoTitles;
  final ValueChanged<int> onSelectDemo;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _navIndex = 0;

  @override
  void didUpdateWidget(covariant _DemoScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.demoIndex != widget.demoIndex) {
      _navIndex = 0;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentTitle = widget.demoTitles[widget.demoIndex];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'floating_pill_navbar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              currentTitle,
              style: TextStyle(
                fontSize: 12,
                color: widget.isDarkMode
                    ? Colors.white.withOpacity(0.7)
                    : Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: widget.isDarkMode ? 'Light mode' : 'Dark mode',
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
          PopupMenuButton<int>(
            tooltip: 'Select Demo Screen',
            icon: const Icon(Icons.tune),
            onSelected: widget.onSelectDemo,
            itemBuilder: (BuildContext context) {
              return List<PopupMenuEntry<int>>.generate(
                widget.demoTitles.length,
                (int i) => PopupMenuItem<int>(
                  value: i,
                  child: Row(
                    children: <Widget>[
                      if (i == widget.demoIndex)
                        const Icon(Icons.check, size: 18)
                      else
                        const SizedBox(width: 18),
                      const SizedBox(width: 8),
                      Text(widget.demoTitles[i]),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            // Horizontal Demo Switcher Chips
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                itemCount: widget.demoTitles.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isSelected = index == widget.demoIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        widget.demoTitles[index]
                            .replaceFirst(RegExp(r'^\d+\.\s*'), ''),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        if (selected) widget.onSelectDemo(index);
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            // Center content card
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    elevation: 0,
                    color: widget.isDarkMode
                        ? const Color(0xFF1E1E22)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: widget.isDarkMode
                            ? Colors.white10
                            : Colors.black.withOpacity(0.06),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode
                                  ? Colors.white10
                                  : const Color(0xFFF1F1F4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getDemoIcon(widget.demoIndex, _navIndex),
                              size: 40,
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _getDemoLabel(widget.demoIndex, _navIndex),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Active tab index: $_navIndex',
                            style: TextStyle(
                              fontSize: 13,
                              color: widget.isDarkMode
                                  ? Colors.white60
                                  : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _getDemoDescription(widget.demoIndex),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavBarForDemo(widget.demoIndex),
    );
  }

  Widget _buildNavBarForDemo(int demoIndex) {
    switch (demoIndex) {
      case 0:
        // 1. Reference design (Chats, Tasks, Brain + circular mic/waveform action button)
        return FloatingPillNavBar(
          selectedIndex: _navIndex,
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
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
            FloatingPillDestination(
              icon: Icons.psychology,
              label: 'Brain',
            ),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.graphic_eq,
            tooltip: 'Voice command',
            onPressed: () => _showSnackBar('Action button tapped!'),
          ),
        );

      case 1:
        // 2. Two-tab navigation
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 1),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(
              icon: Icons.explore_outlined,
              selectedIcon: Icons.explore,
              label: 'Discover',
            ),
            FloatingPillDestination(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Profile',
            ),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.edit,
            onPressed: () => _showSnackBar('Edit action tapped!'),
          ),
        );

      case 2:
        // 3. Four-tab navigation
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 3),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            FloatingPillDestination(
              icon: Icons.search,
              label: 'Search',
            ),
            FloatingPillDestination(
              icon: Icons.bookmark_border,
              selectedIcon: Icons.bookmark,
              label: 'Saved',
            ),
            FloatingPillDestination(
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              label: 'Settings',
            ),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.add,
            tooltip: 'Create post',
            onPressed: () => _showSnackBar('Create post tapped!'),
          ),
        );

      case 3:
        // 4. Without action button
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(
              icon: Icons.dashboard_outlined,
              selectedIcon: Icons.dashboard,
              label: 'Feed',
            ),
            FloatingPillDestination(
              icon: Icons.bar_chart,
              label: 'Analytics',
            ),
            FloatingPillDestination(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Profile',
            ),
          ],
        );

      case 4:
        // 5. Custom colors
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          backgroundColor: const Color(0xFFF5F3FF),
          selectedBackgroundColor: const Color(0xFF7C3AED),
          selectedIconColor: Colors.white,
          selectedLabelColor: Colors.white,
          unselectedIconColor: const Color(0xFF8B5CF6),
          unselectedLabelColor: const Color(0xFF8B5CF6),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(
              icon: Icons.palette_outlined,
              selectedIcon: Icons.palette,
              label: 'Colors',
            ),
            FloatingPillDestination(
              icon: Icons.brush_outlined,
              selectedIcon: Icons.brush,
              label: 'Themes',
            ),
            FloatingPillDestination(
              icon: Icons.color_lens_outlined,
              selectedIcon: Icons.color_lens,
              label: 'Gradients',
            ),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.auto_awesome,
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
            onPressed: () => _showSnackBar('Magic custom action!'),
          ),
        );

      case 5:
        // 6. Custom icons
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: <FloatingPillDestination>[
            FloatingPillDestination(
              customIcon: const FlutterLogo(size: 22),
              customSelectedIcon: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: const FlutterLogo(size: 18),
              ),
              label: 'Flutter',
            ),
            const FloatingPillDestination(
              customIcon: Text(
                '⚡',
                style: TextStyle(fontSize: 18),
              ),
              label: 'Emoji',
            ),
            const FloatingPillDestination(
              icon: Icons.star,
              label: 'Standard',
            ),
          ],
          actionButton: FloatingPillAction(
            child: const Text(
              'GO',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onPressed: () => _showSnackBar('Custom widget action!'),
          ),
        );

      case 6:
        // 7. Badges and notification counts
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(
              icon: Icons.chat_bubble_outline,
              selectedIcon: Icons.chat_bubble,
              label: 'Chats',
              badge: FloatingPillBadge.count(3),
            ),
            FloatingPillDestination(
              icon: Icons.notifications_none,
              selectedIcon: Icons.notifications,
              label: 'Alerts',
              badge: FloatingPillBadge.dot(),
            ),
            FloatingPillDestination(
              icon: Icons.mail_outline,
              selectedIcon: Icons.mail,
              label: 'Inbox',
              badge: FloatingPillBadge.count(120, maxCount: 99),
            ),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.send,
            onPressed: () => _showSnackBar('Send action!'),
          ),
        );

      case 7:
        // 8. Custom animation (bouncy curve & slower duration)
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          animationDuration: const Duration(milliseconds: 500),
          animationCurve: Curves.elasticOut,
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(icon: Icons.speed, label: 'Fast'),
            FloatingPillDestination(icon: Icons.animation, label: 'Smooth'),
            FloatingPillDestination(
                icon: Icons.slow_motion_video, label: 'Slow'),
          ],
          actionButton: FloatingPillAction(
            icon: Icons.play_arrow,
            onPressed: () => _showSnackBar('Play tapped!'),
          ),
        );

      case 8:
        // 9. Dark theme
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          backgroundColor: const Color(0xFF1C1C1E),
          selectedBackgroundColor: const Color(0xFF2C2C2E),
          selectedIconColor: Colors.white,
          selectedLabelColor: Colors.white,
          unselectedIconColor: const Color(0xFF8E8E93),
          unselectedLabelColor: const Color(0xFF8E8E93),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
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
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () => _showSnackBar('Dark mode action!'),
          ),
        );

      case 9:
        // 10. Custom action button (gradient child widget, custom tooltip)
        return FloatingPillNavBar(
          selectedIndex: _navIndex.clamp(0, 2),
          onDestinationSelected: (int index) {
            setState(() => _navIndex = index);
          },
          destinations: const <FloatingPillDestination>[
            FloatingPillDestination(icon: Icons.camera_alt, label: 'Camera'),
            FloatingPillDestination(icon: Icons.photo, label: 'Gallery'),
            FloatingPillDestination(icon: Icons.favorite, label: 'Likes'),
          ],
          actionButton: FloatingPillAction(
            size: 60,
            tooltip: 'Take Photo',
            backgroundColor: Colors.transparent,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.flash_on,
                color: Colors.white,
                size: 28,
              ),
            ),
            onPressed: () => _showSnackBar('Camera snapshot triggered!'),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  IconData _getDemoIcon(int demoIndex, int navIndex) {
    switch (demoIndex) {
      case 0:
        return const <IconData>[
          Icons.chat_bubble,
          Icons.checklist,
          Icons.psychology,
        ][navIndex.clamp(0, 2)];
      case 1:
        return const <IconData>[
          Icons.explore,
          Icons.person
        ][navIndex.clamp(0, 1)];
      case 2:
        return const <IconData>[
          Icons.home,
          Icons.search,
          Icons.bookmark,
          Icons.settings,
        ][navIndex.clamp(0, 3)];
      case 3:
        return const <IconData>[
          Icons.dashboard,
          Icons.bar_chart,
          Icons.person,
        ][navIndex.clamp(0, 2)];
      case 4:
        return const <IconData>[
          Icons.palette,
          Icons.brush,
          Icons.color_lens,
        ][navIndex.clamp(0, 2)];
      case 5:
        return const <IconData>[
          Icons.flutter_dash,
          Icons.bolt,
          Icons.star,
        ][navIndex.clamp(0, 2)];
      case 6:
        return const <IconData>[
          Icons.chat_bubble,
          Icons.notifications,
          Icons.mail,
        ][navIndex.clamp(0, 2)];
      case 7:
        return const <IconData>[
          Icons.speed,
          Icons.animation,
          Icons.slow_motion_video,
        ][navIndex.clamp(0, 2)];
      case 8:
        return const <IconData>[
          Icons.chat_bubble,
          Icons.checklist,
          Icons.psychology,
        ][navIndex.clamp(0, 2)];
      case 9:
        return const <IconData>[
          Icons.camera_alt,
          Icons.photo,
          Icons.favorite,
        ][navIndex.clamp(0, 2)];
      default:
        return Icons.circle;
    }
  }

  String _getDemoLabel(int demoIndex, int navIndex) {
    switch (demoIndex) {
      case 0:
        return const <String>['Chats', 'Tasks', 'Brain'][navIndex.clamp(0, 2)];
      case 1:
        return const <String>['Discover', 'Profile'][navIndex.clamp(0, 1)];
      case 2:
        return const <String>[
          'Home',
          'Search',
          'Saved',
          'Settings',
        ][navIndex.clamp(0, 3)];
      case 3:
        return const <String>[
          'Feed',
          'Analytics',
          'Profile'
        ][navIndex.clamp(0, 2)];
      case 4:
        return const <String>[
          'Colors',
          'Themes',
          'Gradients'
        ][navIndex.clamp(0, 2)];
      case 5:
        return const <String>[
          'Flutter Logo',
          'Emoji ⚡',
          'Standard Star'
        ][navIndex.clamp(0, 2)];
      case 6:
        return const <String>[
          '3 Unread',
          'Dot Alert',
          '120+ Mail'
        ][navIndex.clamp(0, 2)];
      case 7:
        return const <String>[
          'Fast Curve',
          'Smooth Curve',
          'Slow Curve'
        ][navIndex.clamp(0, 2)];
      case 8:
        return const <String>[
          'Dark Chats',
          'Dark Tasks',
          'Dark Brain'
        ][navIndex.clamp(0, 2)];
      case 9:
        return const <String>[
          'Camera',
          'Gallery',
          'Favorites'
        ][navIndex.clamp(0, 2)];
      default:
        return 'Demo';
    }
  }

  String _getDemoDescription(int demoIndex) {
    switch (demoIndex) {
      case 0:
        return 'Pixel-accurate recreation of the reference design with 3 tabs and a circular audio action button.';
      case 1:
        return 'Demonstrates 2-destination configuration with automatic horizontal distribution.';
      case 2:
        return 'Shows 4-destination navigation with balanced spacing and clean typography.';
      case 3:
        return 'Pill navigation rendered cleanly without any floating action button.';
      case 4:
        return 'Custom violet/purple palette demonstrating color overrides.';
      case 5:
        return 'Custom widgets for icons including FlutterLogo and text emojis.';
      case 6:
        return 'Interactive badges: counter (3), dot notification, and 99+ overflow cap.';
      case 7:
        return 'Custom bouncy animation curve (Curves.elasticOut) with 500ms duration.';
      case 8:
        return 'Deep dark theme with high-contrast active states and dark container shadows.';
      case 9:
        return 'Custom action button with gradient background and custom icon sizing.';
      default:
        return '';
    }
  }
}
