import 'dart:ui';
import 'package:character_explorer/controllers/character_controller.dart';
import 'package:character_explorer/widgets/detail_items.dart';
import 'package:character_explorer/widgets/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:character_explorer/models/character_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel model;

  const CharacterDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.white70),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(() {
            final controller = Get.put(CharacterController());
            bool isFav = controller.isFavorite(model.id);
            return IconButton(
              onPressed: () => controller.toggleFavorite(model),
              icon: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : Colors.white,
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          // 1. Large Image Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Hero(
              tag: model.id,
              child: CachedNetworkImage(
                imageUrl: model.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                        color: Color.fromARGB(158, 2, 51, 59),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  model.name,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              StatusIndicator(status: model.status.name),
                            ],
                          ),
                          const SizedBox(height: 32),

                          DetailItems(
                            title: "Species",
                            value: model.species,
                            icon: Icons.pets_outlined,
                          ),
                          DetailItems(
                            title: "Type",
                            value: model.type.isEmpty ? "Unknown" : model.type,
                            icon: Icons.fingerprint,
                          ),
                          DetailItems(
                            title: "Gender",
                            value: model.gender.name,
                            icon: Icons.person_outline,
                          ),
                          DetailItems(
                            title: "Origin",
                            value: model.origin['name'],
                            icon: Icons.public,
                          ),
                          DetailItems(
                            title: "Current Location",
                            value: model.location['name'],
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
      ),
    );
  }
}
