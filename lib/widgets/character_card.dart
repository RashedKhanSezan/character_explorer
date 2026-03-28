import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_explorer/models/character_model.dart';
import 'package:shimmer/shimmer.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel model;
  const CharacterCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: model.id,
              child: CachedNetworkImage(
                imageUrl: model.imagePath,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 116, 115, 115)!,
                  highlightColor: const Color.fromARGB(255, 187, 187, 187)!,
                  child: Container(color: Colors.black),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent.withAlpha(50),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getStatusColor(model.status.name),
                            ),
                          ),
                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              "${model.status.name[0].toUpperCase() + model.status.name.substring(1)} - ${model.species}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'alive':
        return Colors.greenAccent;
      case 'dead':
        return Colors.redAccent;
      default:
        return Colors.black38;
    }
  }
}
