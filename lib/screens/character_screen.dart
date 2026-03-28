import 'dart:ui';
import 'package:character_explorer/screens/character_details_screen.dart';
import 'package:character_explorer/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/widgets/character_card.dart';
import 'package:character_explorer/controllers/character_controller.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CharacterController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
       
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ), 
            child: Container(
              color: Color.fromARGB(120, 5, 120, 138), 
            ),
          ),
        ),
        title: const Text(
          "RICK",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controller.currentNavIndex.value,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0, 0),
                      radius: 1.5,
                      colors: [
                        Color.fromARGB(
                          158,
                          2,
                          51,
                          59,
                        ), 
                        Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ), 
                      ],
                    ),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value &&
                        controller.charlist.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.blueGrey,
                        ),
                      );
                    }
                    return GridView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .8,
                      ),
                      itemCount:
                          controller.charlist.length +
                          (controller.isPaginating.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.charlist.length) {
                          final charItem = controller.charlist[index];
                          return InkWell(
                            onTap: () => Get.to(
                              () => CharacterDetailScreen(model: charItem),
                            ),
                            child: CharacterCard(model: charItem),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.blueGrey,
                            ),
                          );
                        }
                      },
                    );
                  }),
                ), 
                const FavoriteScreen(),
              ],
            ),
          ),

          Positioned(
            bottom: 20, 
            left: 80,
            right: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.08,
                    ), 
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        Icons.home_filled,
                        "Home",
                        true,
                        () => controller.currentNavIndex.value = 0,
                      ),
                      _buildNavItem(
                        Icons.favorite_rounded,
                        "Favorites",
                        false,
                        () => controller.currentNavIndex.value = 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onclick,
  ) {
    return InkWell(
      onTap: onclick,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isActive
                ? Color.fromARGB(120, 5, 120, 138)
                : const Color.fromARGB(
                    121,
                    226,
                    97,
                    96,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
