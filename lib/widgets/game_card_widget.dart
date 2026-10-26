import 'package:flutter/material.dart';

class GameCardWidget extends StatelessWidget {
  const GameCardWidget({
    required this.color,
    required this.isOpen,
    required this.isMatched,
    required this.onTap,
    super.key,
  });

  final Color color;
  final bool isOpen;
  final bool isMatched;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.45,
      child: Material(
        color: isOpen ? color : const Color(0xFFE4E1E9),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: isMatched ? null : onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isMatched
                    ? Colors.white
                    : Colors.black.withValues(alpha: 0.06),
                width: isMatched ? 3 : 1,
              ),
            ),
            child: Center(
              child: Icon(
                isOpen ? Icons.favorite : Icons.help_outline,
                color: isOpen ? Colors.white : const Color(0xFF77727E),
                size: 34,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
