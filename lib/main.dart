import 'package:flutter/material.dart';

void main() {
  runApp(const CharacterExplorer());
}

class CharacterExplorer extends StatelessWidget {
  const CharacterExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}
