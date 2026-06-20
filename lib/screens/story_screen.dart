import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final FlutterTts flutterTts = FlutterTts();

  late ConfettiController confettiController;

  List<dynamic> stories = [];

  bool loading = true;
  bool showQuiz = false;
  bool success = false;
  bool readingStory = false;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    loadStories();

    flutterTts.setCompletionHandler(() {
      setState(() {
        showQuiz = true;
        readingStory = false;
      });
    });
  }

  Future<void> loadStories() async {
    final jsonString = await rootBundle.loadString('lib/json/helper.json');

    final data = jsonDecode(jsonString);

    stories = data['stories'];

    setState(() {
      loading = false;
    });
  }

  Future<void> readStory() async {
    setState(() {
      readingStory = true;
      showQuiz = false;
      success = false;
    });

    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.45);

    await flutterTts.speak(stories[currentIndex]['story']);
  }

  void checkAnswer(String selected) {
    final answer = stories[currentIndex]['quiz']['answer'];

    if (selected == answer) {
      confettiController.play();

      setState(() {
        success = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Wrong Answer! Try Again")),
      );
    }
  }

  void nextStory() {
    if (currentIndex < stories.length - 1) {
      setState(() {
        currentIndex++;
        showQuiz = false;
        success = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎉 All Stories Completed!")),
      );
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final story = stories[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6E5),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [
                ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                ),

                CircleAvatar(
                  radius: 60,
                  backgroundColor: success ? Colors.green : Colors.orange,

                  child: Icon(
                    success ? Icons.sentiment_very_satisfied : Icons.smart_toy,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  story['title'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: readingStory ? null : readStory,

                  child: Text(readingStory ? "Reading..." : "Read Me A Story"),
                ),

                const SizedBox(height: 20),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      story['story'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (showQuiz)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        children: [
                          Text(
                            story['quiz']['question'],

                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          ...List.generate(story['quiz']['options'].length, (
                            index,
                          ) {
                            final option = story['quiz']['options'][index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),

                              child: SizedBox(
                                width: double.infinity,

                                child: ElevatedButton(
                                  onPressed: () {
                                    checkAnswer(option);
                                  },
                                  child: Text(option),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                if (success)
                  Column(
                    children: [
                      const SizedBox(height: 20),

                      const Text(
                        "🎉 Correct!",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: nextStory,

                        child: const Text("Next Story"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
