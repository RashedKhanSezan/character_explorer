import 'dart:ui';
import 'package:character_explorer/widgets/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/screens/character_details_screen.dart';
import 'package:character_explorer/screens/favorite_screen.dart';
import 'package:character_explorer/widgets/character_search_bar.dart';
import 'package:character_explorer/widgets/character_card.dart';
import 'package:character_explorer/controllers/character_controller.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CharacterController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Color.fromARGB(96, 12, 156, 179)),
          ),
        ),
        title: Obx(
          () => Text(
            controller.currentNavIndex.value == 1 ? "FAVORITES" : 'RICK',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            radius: 1.5,
            colors: [
              Color.fromARGB(158, 2, 51, 59),
              Color.fromARGB(76, 7, 132, 151),
            ],
          ),
        ),
        child: Obx(
          () => IndexedStack(
            index: controller.currentNavIndex.value,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  ),

                  const CharacterSearchBar(),

                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value &&
                          controller.charlist.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.blueGrey,
                          ),
                        );
                      }

                      final displayList = controller.filteredCharacters;

                      if (displayList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No characters found",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return GridView.builder(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: .8,
                            ),
                        itemCount:
                            displayList.length +
                            (controller.isPaginating.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < displayList.length) {
                            final charItem = displayList[index];
                            return InkWell(
                              onTap: () => Get.to(
                                () => CharacterDetailScreen(model: charItem),
                              ),
                              child: CharacterCard(model: charItem),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.blueGrey,
                              ),
                            );
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),

              const FavoriteScreen(),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingNavbar(controller: controller),
    );
  }
}
