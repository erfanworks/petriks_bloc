import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constant/const_color.dart';

/// iOS-এ keyboard-এর উপরে "Done" bar দেখায়।
/// Android-এ কিছুই বদলায় না।
class KeyboardDoneBar extends StatelessWidget {
  final Widget child;
  const KeyboardDoneBar({super.key, required this.child});

  static const double barHeight = 44;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform != TargetPlatform.iOS) return child;

    final mq = MediaQuery.of(context);
    final keyboardHeight = mq.viewInsets.bottom;
    final isOpen = keyboardHeight > 0;

    return Stack(
      fit: StackFit.expand,
      children: [
        // bar-এর উচ্চতা viewInsets-এ যোগ, যাতে কোনো স্ক্রিনের UI ঢেকে না যায়
        MediaQuery(
          data: mq.copyWith(
            viewInsets: mq.viewInsets.copyWith(
              bottom: isOpen ? keyboardHeight + barHeight : 0,
            ),
          ),
          child: child,
        ),
        if (isOpen)
          Positioned(
            left: 0,
            right: 0,
            bottom: keyboardHeight,
            height: barHeight,
            child: Material(
              color: const Color(0xFFF2F2F7),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: ConstColor.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
