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
  late Box<int> favoriteBox;

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
    scrollController = ScrollController()..addListener(_scrollListener);
    characterBox = Hive.box<CharacterModel>('characters');
    favoriteBox = await Hive.openBox<int>('favorites');

    if (characterBox.isNotEmpty) {
      charlist.assignAll(characterBox.values.toList());
      _loadFavoritesFromCache();
      isLoading(false);
    }

    fetchData();
    super.onInit();
  }

  void _loadFavoritesFromCache() {
    final favIds = favoriteBox.values.toList();
    final favorites = charlist
        .where((char) => favIds.contains(char.id))
        .toList();
    favCharList.assignAll(favorites);
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
        "Original API data not found. Try refreshing.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white10,
        colorText: Colors.white,
      );
    }
  }

  void toggleFavorite(CharacterModel model) {
    if (favoriteBox.containsKey(model.id)) {
      favoriteBox.delete(model.id);
      favCharList.removeWhere((item) => item.id == model.id);
    } else {
     
      favCharList.add(model);
      favoriteBox.put(model.id, model.id);
    }
    favCharList.refresh(); 
  }

  bool isFavorite(int id) {
    
    return favCharList.any((char) => char.id == id);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
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
        var allChar = CharacterData.fromJson(response.data);
        originalApiData = allChar.allCharacter;

        for (var char in allChar.allCharacter) {
          if (!characterBox.containsKey(char.id)) {
            characterBox.put(char.id, char);
          }
        }

        charlist.assignAll(characterBox.values.toList());
        _loadFavoritesFromCache();
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Something Wrong',
        e.response?.data['error'] ?? "Connection error",
      );
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
        var nextAllchar = CharacterData.fromJson(response.data);
        originalApiData.addAll(nextAllchar.allCharacter);

        for (var char in nextAllchar.allCharacter) {
          if (!characterBox.containsKey(char.id)) {
            characterBox.put(char.id, char);
          }
        }

        final uniqueList = characterBox.values.toList();
        charlist.assignAll(uniqueList);

        hasMorePage = response.data['info']['next'] != null;
      }
    } on DioException catch (error) {
      currentpage--;
      debugPrint(error.message);
    } finally {
      isPaginating(false);
    }
  }
}
