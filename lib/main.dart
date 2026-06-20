import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peblostorybuddy/screens/Loading.dart';

import 'screens/story_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Peblo Story Buddy",
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}
