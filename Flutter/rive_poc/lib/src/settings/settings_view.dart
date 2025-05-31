import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_poc/rive_asset.dart';

import '../../utils/rive_utils.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  RiveAsset selectedBottomNav = bottomNavs.first;

  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('indle');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.controller.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              value: widget.controller.themeMode,
              onChanged: widget.controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.isActive = !_controller.isActive;
                  });
                },
                child: RiveAnimation.asset(
                  isDark
                      ? 'assets/animated_icons_white.riv'
                      : 'assets/animated_icons.riv',
                  controllers: [_controller],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: !isDark ? Colors.white : Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomNavs.length,
              (index) {
                final navItem = bottomNavs[index];
                final isSelected = navItem == selectedBottomNav;

                return GestureDetector(
                  onTap: () {
                    navItem.input?.change(true);
                    if (!isSelected) {
                      setState(() {
                        selectedBottomNav = navItem;
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      navItem.input?.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: isSelected ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            isDark ? navItem.srcLight : navItem.srcDark,
                            key: ValueKey(
                              '${navItem.artboard}_${isDark ? "light" : "dark"}',
                            ),
                            artboard: navItem.artboard,
                            onInit: (artboard) {
                              final controller = RiveUtils.getRiveController(
                                artboard,
                                stateMachineName: navItem.stateMachineName,
                              );
                              final input =
                                  controller.findSMI('active') as SMIBool;
                              navItem.setInput = input;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
