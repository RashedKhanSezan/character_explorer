import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:character_explorer/controllers/character_controller.dart';
import 'package:character_explorer/widgets/detail_items.dart';
import 'package:character_explorer/widgets/reset_button.dart';
import 'package:character_explorer/widgets/status_indicator.dart';
import 'package:character_explorer/widgets/edit_character_sheet.dart';
import 'package:character_explorer/models/character_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel model;

  const CharacterDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharacterController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                EditCharacterSheet(character: model),
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            icon: const Icon(
              Icons.edit_note_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          Obx(() {
            bool isFav = controller.isFavorite(model.id);
            return IconButton(
              onPressed: () => controller.toggleFavorite(model),
              icon: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : Colors.white,
                size: 30,
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        final latestModel = controller.charlist.firstWhere(
          (c) => c.id == model.id,
          orElse: () => model,
        );

        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Hero(
                tag: latestModel.id,
                child: CachedNetworkImage(
                  imageUrl: latestModel.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.42),
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(158, 2, 51, 59),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    latestModel.name,
                                    maxLines: 4,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),

                                StatusIndicator(
                                  status: latestModel.status.name,
                                ),

                                Spacer(flex: 1),

                                ResetButton(characterId: model.id.toString()),
                              ],
                            ),
                            const SizedBox(height: 32),
                            DetailItems(
                              title: "Species",
                              value:
                                  latestModel.species[0].toUpperCase() +
                                  latestModel.species.substring(1),
                              icon: Icons.pets_outlined,
                            ),
                            DetailItems(
                              title: "Type",
                              value: latestModel.type.isEmpty
                                  ? "Unknown"
                                  : latestModel.type[0].toUpperCase() +
                                        latestModel.type.substring(1),
                              icon: Icons.fingerprint,
                            ),
                            DetailItems(
                              title: "Gender",
                              value:
                                  latestModel.gender.name[0].toUpperCase() +
                                  latestModel.gender.name.substring(1),
                              icon: Icons.person_outline,
                            ),
                            DetailItems(
                              title: "Origin",
                              value:
                                  latestModel.origin['name'][0]
                                      .toString()
                                      .toUpperCase() +
                                  latestModel.origin['name']
                                      .toString()
                                      .substring(1),
                              icon: Icons.public,
                            ),
                            DetailItems(
                              title: "Current Location",
                              value: latestModel.location['name'],
                              icon: Icons.location_on_outlined,
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
