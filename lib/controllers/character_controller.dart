import 'dart:convert';

import 'package:character_explorer/models/character_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CharacterController extends GetxController {
  var charlist = <CharacterModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character'),
      );

      if (response.statusCode == 200) {
        final charData = jsonDecode(response.body);

        var allChar = CharacterData.fromJson(charData);
        charlist.addAll(allChar.allCharacter);
      }
    } on Exception catch (e) {
      Get.snackbar('Something', '$e');
    } finally {
      isLoading(false);
    }
  }
}
