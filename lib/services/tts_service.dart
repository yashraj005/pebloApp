import 'package:flutter/animation.dart' show VoidCallback;
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, VoidCallback onComplete) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.45);

    flutterTts.setCompletionHandler(onComplete);

    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
