import 'package:character_explorer/models/character_model.dart';
import 'package:character_explorer/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox<CharacterModel>('characters');
  runApp(const CharacterExplorer());
}

class CharacterExplorer extends StatelessWidget {
  const CharacterExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RIck & Morty Verse',
      debugShowCheckedModeBanner: false,
      home: CharacterScreen(),
    );
  }
}
