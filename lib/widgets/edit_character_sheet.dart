import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/character_model.dart';
import '../controllers/character_controller.dart';

class EditCharacterSheet extends StatefulWidget {
  final CharacterModel character;

  const EditCharacterSheet({super.key, required this.character});

  @override
  State<EditCharacterSheet> createState() => _EditCharacterSheetState();
}

class _EditCharacterSheetState extends State<EditCharacterSheet> {

  late final TextEditingController nameCtrl;
  late final TextEditingController speciesCtrl;
  late final TextEditingController typeCtrl;
  late final TextEditingController originCtrl;
  late final TextEditingController locationCtrl;


  late final Rx<Status> selectedStatus;
  late final Rx<Gender> selectedGender;

  @override
  void initState() {
    super.initState();
 
    nameCtrl = TextEditingController(text: widget.character.name);
    speciesCtrl = TextEditingController(text: widget.character.species);
    typeCtrl = TextEditingController(text: widget.character.type);
    originCtrl = TextEditingController(text: widget.character.origin['name']);
    locationCtrl = TextEditingController(
      text: widget.character.location['name'],
    );

    selectedStatus = widget.character.status.obs;
    selectedGender = widget.character.gender.obs;
  }

  @override
  void dispose() {
   
    nameCtrl.dispose();
    speciesCtrl.dispose();
    typeCtrl.dispose();
    originCtrl.dispose();
    locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharacterController>();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 18,
          bottom: 18,
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(99, 2, 51, 59),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: Colors.white10),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHandleBar(),
                const SizedBox(height: 10),
                const Text(
                  "EDIT VERSE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),

                _buildEditField("NAME", nameCtrl),
                _buildEditField("SPECIES", speciesCtrl),
                _buildEditField("TYPE", typeCtrl),
                _buildEditField("ORIGIN", originCtrl),
                _buildEditField("LOCATION", locationCtrl),

                const SizedBox(height: 20),
                _buildSectionHeader("STATUS"),

                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: Status.values
                        .map((s) => _buildStatusChip(s))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 10),
                _buildSaveButton(controller),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildHandleBar() => Container(
    width: 40,
    height: 4,
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(2),
    ),
  );

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white38,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildStatusChip(Status s) {
    final isSelected = selectedStatus.value == s;
    return ChoiceChip(
      label: Text(s.name.toUpperCase(), style: const TextStyle(fontSize: 10)),
      selected: isSelected,
      onSelected: (_) => selectedStatus.value = s,
      selectedColor: const Color.fromARGB(235, 72, 192, 122),
      backgroundColor: Colors.white10,
      labelStyle: TextStyle(color: Colors.black),
    );
  }

  Widget _buildSaveButton(CharacterController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(150, 95, 255, 162),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          final updated = widget.character.copyWith(
            name: nameCtrl.text,
            species: speciesCtrl.text,
            type: typeCtrl.text,
            status: selectedStatus.value,
            gender: selectedGender.value,
            originName: originCtrl.text,
            locationName: locationCtrl.text,
          );
          controller.updateCharacter(updated);
          Get.back();
        },
        child: const Text(
          "SAVE TO DEVICE",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38, fontSize: 16),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 95, 255, 161)),
        ),
      ),
    );
  }
}
