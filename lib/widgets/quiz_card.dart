import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizWidget extends StatelessWidget {
  final QuizModel quiz;
  final Function(String) onSelected;

  const QuizWidget({super.key, required this.quiz, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              quiz.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ...quiz.options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onSelected(option),
                    child: Text(option),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
