import 'package:flutter/material.dart';

class Navitem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onclick;
  const Navitem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive
                ? const Color.fromARGB(235, 72, 192, 122)
                : const Color.fromARGB(185, 226, 96, 96),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? Colors.white
                  : const Color.fromARGB(225, 255, 255, 255),
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
