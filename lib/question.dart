import 'package:flutter/material.dart';

enum QuestionType { multipleChoice, shortText, multipleSelect }

class Question {
  final String text; // The question text
  final QuestionType type; // The type of question
  final List<String>? options; // For multiple choice/select questions
  final String? placeholder; // Placeholder text for short text questions
  final TextInputType? keyboardType; // Keyboard type for short text questions
  final int? maxLines; // Maximum lines for short text questions

  Question({
    required this.text,
    required this.type,
    this.options,
    this.placeholder,
    this.keyboardType,
    this.maxLines = 1, // Default maxLines to 1 for short text
  });
}