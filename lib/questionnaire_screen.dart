import 'package:flutter/material.dart';
import 'package:myapp/question.dart';

class QuestionnaireScreen extends StatefulWidget {
  final List<Question> questions;

  const QuestionnaireScreen({super.key, required this.questions});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentQuestionIndex = 0;
  List<dynamic> _answers = [];
  bool _hasError = false; // Track error state
  String _errorMessage = ''; // Store error message
  Color myGreen = Color.fromRGBO(76, 175, 80, 0.8);
  bool _isSubmitting = false;

  // Store TextEditingControllers
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _answers = List<dynamic>.filled(widget.questions.length, null);
    _textControllers = List.generate(
        widget.questions.length,
        (index) => TextEditingController(
            text: _answers[index] is String ? _answers[index] as String : ''));
  }

  @override
  void dispose() {
    for (final controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitQuestionnaire() async {
    setState(() {
      _isSubmitting = true;
    });

    // Simulate a submission process (replace with your actual submission logic)
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Simulate a check on the code (assuming you have a way to validate it)
    bool isValidCode = true; // Replace with your actual validation

    setState(() {
      _isSubmitting = false;
    });

    if (isValidCode) {
      // Navigate to confirmation screen after submission after the snackbar disappears.
      Navigator.pushReplacementNamed(context, '/confirmation');
    // ignore: dead_code
    } else {
      // Show error message
      setState(() {
        _hasError = true;
        _errorMessage = 'Invalid login code. Please try again.';
      });

      // Auto-dismiss after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _hasError = false;
          _errorMessage = '';
        });
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Submit the questionnaire
      _submitQuestionnaire();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if there are any questions and handle the case of an empty list
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Questionnaire'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const Center(child: Text('No questions available.')),
      );
    }

    final currentQuestion = widget.questions[_currentQuestionIndex];
    final bool isLastQuestion =
        _currentQuestionIndex == widget.questions.length - 1;
    final progressPercentage =
        (_currentQuestionIndex + 1) / widget.questions.length;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(
      //   title: const Text('Post-Op Survey'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question progress text (e.g., "Question 1 of 5")
                Text(
                  '${_currentQuestionIndex + 1} of ${widget.questions.length}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                // Progress Indicator with percentage
                LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    myGreen, // Green with opacity
                  ),
                  value: progressPercentage,
                ),
                Text(
                  '${(progressPercentage * 100).toStringAsFixed(0)}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 24.0),
                // Question text
                Text(
                  currentQuestion.text,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                // Question options (buttons)
                Expanded(
                  child: _buildQuestionWidget(
                    currentQuestion,
                    _currentQuestionIndex,
                  ),
                ),
                const SizedBox(height: 24.0),
                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    if (_currentQuestionIndex > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousQuestion,
                          child: const Text('Back'),
                        ),
                      ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isAnswered(_currentQuestionIndex) && !_isSubmitting
                            ? _nextQuestion
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myGreen, // Green with opacity
                        ),
                        child: _isSubmitting
                            ? const Text('Submitting...')
                            : Text(
                                isLastQuestion ? 'Submit' : 'Next',
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Error popup - bottom left
          if (_hasError)
            Positioned(
              bottom: 20,
              left: 20,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.red[400],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _hasError = false;
                            _errorMessage = '';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _answerQuestion(int questionIndex, dynamic answer) {
    setState(() {
      _answers[questionIndex] = answer;
    });
  }

  Widget _buildQuestionWidget(Question question, int index) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return _buildMultipleChoiceQuestion(question, index);
      case QuestionType.shortText:
        return _buildShortTextQuestion(question, index);
      case QuestionType.multipleSelect:
        return _buildMultipleSelectQuestion(question, index);
      // ignore: unreachable_switch_default
      default:
        return Center(child: Text('Unknown question type: ${question.type}'));
    }
  }

  // Widget to build multiple choice questions
  Widget _buildMultipleChoiceQuestion(Question question, int index) {
    // Ensure the answer is a String or null for multiple choice
    if (_answers[index] != null && _answers[index] is! String) {
      // Reset if the type is unexpectedly not a String
      _answers[index] = null;
    }
    return ListView.builder(
      itemCount: question.options!.length,
      itemBuilder: (context, optionIndex) {
        final option = question.options![optionIndex];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _answers[index] == option ? myGreen : Colors.transparent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: RadioListTile(
            title: Text(option),
            value: option,
            groupValue: _answers[index],
            onChanged: (value) {
              _answerQuestion(index, value);
            },
            activeColor: myGreen,
          ),
        );
      },
    );
  }

  Widget _buildMultipleSelectQuestion(Question question, int index) {
    // Ensure the answer is a List<String> for multiple select
    if (_answers[index] == null || _answers[index] is! List<String>) {
      // Initialize with an empty list if null or wrong type
      _answers[index] = <String>[];
    }
    return ListView.builder(
      itemCount: question.options!.length,
      itemBuilder: (context, optionIndex) {
        final option = question.options![optionIndex];
        // Ensure the answer is a List<String> before accessing it
        final List<String> selectedOptions = (_answers[index] as List<String>);
        return CheckboxListTile(
          title: Text(
            option,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          value: selectedOptions.contains(option),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                selectedOptions.add(option);
              } else {
                selectedOptions.remove(option);
              }
              _answers[index] = selectedOptions; // Update the answer in the list
            });
          },
          activeColor: myGreen, // Green with opacity
        );
      },
    );
  }

  Widget _buildShortTextQuestion(Question question, int index) {
    // Ensure the answer is a String or null for short text
    if (_answers[index] != null && _answers[index] is! String) {
      // Reset if the type is unexpectedly not a String
      _answers[index] = null;
    }

    // Create a TextEditingController and set its initial value
    final textController = TextEditingController(
      text: _answers[index] is String ? _answers[index] as String : '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: ValueKey(_answers[index]), // Use ValueKey to preserve state
          controller: textController, // Assign the controller
          onChanged: (value) {
            // Update the text answer
            setState(() {
              _answers[index] = value;
            });
          },
          decoration: InputDecoration(
            hintText: question.placeholder ?? 'Enter your answer here',
          ),
          keyboardType: question.keyboardType,
          maxLines: question.maxLines,
        ),
      ],
    );
  }

  // Helper method to check if a question has been answered
  bool _isAnswered(int index) {
    // Handle case where index is out of bounds (shouldn't happen with correct logic)
    if (index < 0 || index >= widget.questions.length) {
      return false;
    }

    final question = widget.questions[index];
    final answer = _answers[index];

    switch (question.type) {
      case QuestionType.multipleChoice:
        return answer != null; // An answer is selected if not null
      case QuestionType.multipleSelect:
        return answer != null &&
            answer is List &&
            (answer).isNotEmpty; // Check if it's a non-empty list
      case QuestionType.shortText:
        // Check if it's a non-empty string after trimming whitespace
        return answer != null &&
            (answer is String) &&
            (answer).trim().isNotEmpty;
      // ignore: unreachable_switch_default
      default:
        return false; // Default to not answered for unknown types
    }
  }
}
