import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:character_explorer/models/character_model.dart';

class CharacterController extends GetxController {
  final Dio _dio = Dio();
  final charlist = <CharacterModel>[].obs;
  var isLoading = true.obs;
  var isPaginating = false.obs;
  int currentpage = 1;
  bool hasMorePage = true;
  late ScrollController scrollController;

  var currentNavIndex = 0.obs;

  final favCharList = <CharacterModel>[].obs;

  void toggleFavorite(CharacterModel model) {
    if (favCharList.any((item) => item.id == model.id)) {
      favCharList.removeWhere((item) => item.id == model.id);
    } else {
      favCharList.add(model);
    }
  }

  bool isFavorite(int id) {
    return favCharList.any((item) => item.id == id);
  }

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListner);
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListner() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (isPaginating(true) && hasMorePage) {
        fetchforPagination();
      }
    }
  }

  void fetchData() async {
    try {
      isLoading(true);
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      if (response.statusCode == 200) {
        var charData = response.data;
        // print(charData.keys);
        var allChar = CharacterData.fromJson(charData);

        charlist.assignAll(allChar.allCharacter);
      }
    } on DioException catch (e) {
      String errormsg = e.response?.data['error'] ?? "Some error";

      Get.snackbar('Somthing Wrong', errormsg);
    } finally {
      isLoading(false);
    }
  }

  void fetchforPagination() async {
    try {
      isPaginating(true);
      currentpage++;
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character?page=$currentpage',
      );

      if (response.statusCode == 200) {
        var nextcharData = response.data;
        var nextAllchar = CharacterData.fromJson(nextcharData);
        charlist.addAll(nextAllchar.allCharacter);

        hasMorePage = nextcharData['info']['next'] != null;
      }
    } on DioException catch (error) {
      currentpage--;
      debugPrint(error.message);
    } finally {
      isPaginating(false);
    }
  }
}
