import 'dart:async';

import 'package:flutter/material.dart';
import 'story_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StoryScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6E5),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              height: 140,
              width: 140,

              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.smart_toy,
                size: 80,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Peblo Story Buddy",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Learning Through Stories",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),

            const SizedBox(height: 15),

            const Text("Loading Adventures...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
