import 'package:character_explorer/screens/character_details_screen.dart';
import 'package:character_explorer/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/controllers/character_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharacterController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.currentNavIndex.value == 1 ? "FAVORITES" : 'RICK',
            style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 4, 107, 126),
              Color.fromARGB(255, 5, 10, 14),
            ],
            radius: 1.5,
          ),
        ),
        child: Obx(() {
          if (controller.favCharList.isEmpty) {
            return const Center(
              child: Text(
                "No favorites yet, Rick!",
                style: TextStyle(color: Colors.white54),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(10, 110, 10, 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: controller.favCharList.length,
            itemBuilder: (context, index) {
              final favItem = controller.favCharList[index];
              return InkWell(
                onTap: () =>
                    Get.to(() => CharacterDetailScreen(model: favItem)),
                child: CharacterCard(model: favItem),
              );
            },
          );
        }),
      ),
    );
  }
}
