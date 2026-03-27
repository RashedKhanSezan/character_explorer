import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:character_explorer/models/character_model.dart';

class CharacterController extends GetxController {
  var charlist = <CharacterModel>[].obs;
  var isLoading = true.obs;
  final Dio _dio = Dio();

  void fetchData() async {
    try {
      isLoading(true);
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      if (response.statusCode == 200) {
        var charData = response.data;
        var allChar = CharacterData.fromJson(charData);

        charlist.assignAll(allChar.allCharacter);
      }
    } on DioException catch (e) {
      String errormsg = e.response!.data['error'] ?? "Some error";

      Get.snackbar('Somthing Wrong', errormsg);
    }
  }
}
