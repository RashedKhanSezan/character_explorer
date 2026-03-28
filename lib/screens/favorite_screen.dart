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
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(158, 2, 51, 59),
              Color.fromARGB(76, 7, 132, 151),
            ],
            radius: 1.5,
          ),
        ),
        child: Obx(() {
          if (controller.favCharList.isEmpty) {
            return const Center(
              child: Text(
                "No favorites yet, Rick!!!",
                style: TextStyle(color: Colors.white54, fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(10, 120, 10, 10),
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
