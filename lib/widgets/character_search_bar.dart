import 'package:character_explorer/controllers/character_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterSearchBar extends StatelessWidget {
  const CharacterSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharacterController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (val) => controller.searchQuery.value = val,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search characters...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 30,
                color: Color.fromARGB(255, 84, 223, 142),
              ),
              filled: true,
              fillColor: Color.fromARGB(76, 7, 132, 151),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip("All", controller),
                _buildFilterChip("Alive", controller),
                _buildFilterChip("Dead", controller),
                _buildFilterChip("Unknown", controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, CharacterController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Obx(() {
        final isSelected = controller.selectedStatus.value == label;
        return FilterChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (val) => controller.selectedStatus.value = label,
          selectedColor: const Color.fromARGB(235, 72, 192, 122),
          backgroundColor: Colors.white10,
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          checkmarkColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}
