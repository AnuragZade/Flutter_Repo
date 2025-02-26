import 'package:flutter/material.dart';

import 'implicit_animations/animation_tween_animation_builder.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedTweeenBuilder(),
    );
  }
}
