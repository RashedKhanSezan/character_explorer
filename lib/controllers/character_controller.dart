import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:character_explorer/models/character_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterController extends GetxController {
  final Dio _dio = Dio();
  final charlist = <CharacterModel>[].obs;
  var isLoading = true.obs;
  var isPaginating = false.obs;
  int currentpage = 1;
  bool hasMorePage = true;
  late ScrollController scrollController;


  var searchQuery = "".obs;
  var selectedStatus = "All".obs;


  List<CharacterModel> originalApiData = [];


  var currentNavIndex = 0.obs;
  final favCharList = <CharacterModel>[].obs;

  late Box<CharacterModel> characterBox;


  List<CharacterModel> get filteredCharacters {
    if (searchQuery.value.isEmpty && selectedStatus.value == "All") {
      return charlist;
    }

    return charlist.where((char) {
      final matchesSearch = char.name.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );

      final matchesStatus =
          selectedStatus.value == "All" ||
          char.status.name.toLowerCase() == selectedStatus.value.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  void onInit() async {
    scrollController = ScrollController()..addListener(_scrollListner);


    characterBox = Hive.box<CharacterModel>('characters');


    if (characterBox.isNotEmpty) {
      charlist.assignAll(characterBox.values.toList());
      isLoading(false);
    }

    fetchData();
    super.onInit();
  }


  void updateCharacter(CharacterModel updatedModel) {

    characterBox.put(updatedModel.id, updatedModel);


    int mainIndex = charlist.indexWhere((item) => item.id == updatedModel.id);
    if (mainIndex != -1) charlist[mainIndex] = updatedModel;


    int favIndex = favCharList.indexWhere((item) => item.id == updatedModel.id);
    if (favIndex != -1) {
      favCharList[favIndex] = updatedModel;
      favCharList.refresh();
    }

    charlist.refresh();
  }

  void resetToDefault(String idString) {
    try {
  
      int id = int.parse(idString);


      final original = originalApiData.firstWhere((c) => c.id == id);

  
      final index = charlist.indexWhere((c) => c.id == id);

      if (index != -1) {
        final revertedModel = original.copyWith();

        charlist[index] = revertedModel;

      
        characterBox.put(id, revertedModel);

        int favIndex = favCharList.indexWhere((item) => item.id == id);
        if (favIndex != -1) {
          favCharList[favIndex] = revertedModel;
          favCharList.refresh();
        }

        charlist.refresh();
      }
    } catch (e) {
      debugPrint("Reset Error: $e");
      Get.snackbar(
        "Notice",
        "Original API data not found in memory.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white10,
        colorText: Colors.white,
      );
    }
  }


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
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListner() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isPaginating.value && hasMorePage) {
        fetchforPagination();
      }
    }
  }


  void fetchData() async {
    try {
      if (charlist.isEmpty) isLoading(true);
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      if (response.statusCode == 200) {
        var charData = response.data;
        var allChar = CharacterData.fromJson(charData);


        originalApiData = allChar.allCharacter;

        for (var char in allChar.allCharacter) {
          if (!characterBox.containsKey(char.id)) {
            characterBox.put(char.id, char);
          }
        }

        charlist.assignAll(characterBox.values.toList());
      }
    } on DioException catch (e) {
      String errormsg = e.response?.data['error'] ?? "Connection error";
      Get.snackbar('Something Wrong', errormsg);
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


        originalApiData.addAll(nextAllchar.allCharacter);

        for (var char in nextAllchar.allCharacter) {
          if (!characterBox.containsKey(char.id)) {
            characterBox.put(char.id, char);
          }
        }
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
