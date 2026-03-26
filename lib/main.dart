import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CharacterExplorer());
}

class CharacterExplorer extends StatelessWidget {
  const CharacterExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false);
  }
}
