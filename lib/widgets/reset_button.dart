import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/controllers/character_controller.dart';

class ResetButton extends StatelessWidget {
  final String characterId;
  const ResetButton({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharacterController>();

    return OutlinedButton(
      onPressed: () => _showGlassyResetDialog(context, controller),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 87, 94, 95),
        backgroundColor: const Color.fromARGB(235, 72, 192, 122),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: const BorderSide(color: Color.fromARGB(235, 72, 192, 122)),
        padding: const EdgeInsets.all(6),
      ),
      child: const Text(
        'RESET',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _showGlassyResetDialog(
    BuildContext context,
    CharacterController controller,
  ) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
          title: const Text(
            "Confirm Reset",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, letterSpacing: 1.2),
          ),
          content: const Text(
            "This will revert all manual edits to the default values.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.resetToDefault(characterId);
                Get.back();
                Get.snackbar(
                  "Success",
                  "Restored to default",
                  backgroundColor: Colors.black45,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(15),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  235,
                  72,
                  192,
                  122,
                ).withOpacity(0.8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("RESET"),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }
}
