import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const Color myGreen = Color.fromRGBO(76, 175, 80, 0.8);

    return Scaffold(
      backgroundColor: colorScheme.background, // White background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Icon(
                  Icons.check_circle,
                  color: myGreen,
                  size: 120.0,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                "Submission Successful!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0, // Larger font size
                  fontWeight: FontWeight.w600, // Slightly bolder
                  color: colorScheme.onSurface, // Use onBackground for text color
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Your answers have been successfully submitted to your healthcare provider.\nThank you for completing the questionnaire.\nYour doctor will review your answers.\nIf you have any urgent concerns, please contact your clinic directly.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 32.0), // Add some spacing before the button
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the Dashboard screen (assuming a dashboard route exists)
                  // If no dashboard, navigate back to the login screen or home.
                  // For now, let's navigate back to login as it's the initial route.
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: myGreen, // Green button with opacity
                  foregroundColor: colorScheme.onTertiary, // White text
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text('Return to Home'), // Updated button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}