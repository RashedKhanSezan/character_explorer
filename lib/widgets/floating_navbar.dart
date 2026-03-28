import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/controllers/character_controller.dart';
import 'package:character_explorer/widgets/navitem.dart';


class FloatingNavbar extends StatelessWidget {
  final CharacterController controller;

  const FloatingNavbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 70,
            width: 220,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Navitem(
                  icon: Icons.home_filled,
                  label: "Home",
                  isActive: controller.currentNavIndex.value == 0,
                  onclick: () => controller.currentNavIndex.value = 0,
                ),
                Navitem(
                  icon: Icons.favorite_rounded,
                  label: "Favorites",
                  isActive: controller.currentNavIndex.value == 1,
                  onclick: () => controller.currentNavIndex.value = 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
