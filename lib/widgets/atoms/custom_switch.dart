import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> controller;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final bool initialValue;

  const CustomSwitch({
    super.key,
    required this.controller,
    this.enabled = true,
    required this.onChanged,
    this.initialValue = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const switchWidth = 48.0;
    const switchHeight = 28.0;
    final activeColor = colorScheme.primary.withOpacity(0.32);
    final inactiveColor = colorScheme.secondary;
    final thumbOnColor = colorScheme.primary;
    final thumbOffColor = Theme.of(context).iconTheme.color ?? Colors.white70;
    final switchBorderRadius = BorderRadius.circular(switchHeight / 2);

    return AdvancedSwitch(
      initialValue: initialValue,
      controller: controller,
      enabled: enabled,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      borderRadius: switchBorderRadius,
      width: switchWidth,
      height: switchHeight,
      thumb: ValueListenableBuilder<bool>(
        valueListenable: controller,
        builder: (_, value, __) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? thumbOnColor : thumbOffColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              value ? Icons.check_rounded : Icons.close_rounded,
              size: switchHeight * 0.48,
              color: value
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.92),
            ),
          );
        },
      ),
      onChanged: (value) {
        if (value is bool) {
          onChanged(value);
        }
      },
    );
  }
}
