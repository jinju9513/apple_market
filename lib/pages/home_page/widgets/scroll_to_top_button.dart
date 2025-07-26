import 'package:flutter/material.dart';

class ScrollToTopButton extends StatelessWidget {
  final bool show;
  final bool isPressed;
  final VoidCallback onTap;

  const ScrollToTopButton({
    super.key,
    required this.show,
    required this.isPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: show
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isPressed ? Icons.check : Icons.keyboard_arrow_up,
                  size: 24,
                  color: Colors.grey[800],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
