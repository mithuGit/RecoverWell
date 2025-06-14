import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _errorMessage = '';
  bool _isVerifying = false;

  // Dummy valid codes (replace with your actual validation logic)
  final List<String> _validCodes = ['123456', 'abcdef', '987654'];

  void _continue() async {
    setState(() {
      _isVerifying = true;
    });

    final code = _codeController.text;

    // Validation
    await Future.delayed(const Duration(seconds: 1)); // Simulate verification delay
    if (_validCodes.contains(code) && code.length >= 6 && code.length <= 10) {
      setState(() {
        _isVerifying = false;
      });
      // Navigate to the questionnaire screen after successful login
      Navigator.pushReplacementNamed(context, '/questionnaire');
    } else {
      setState(() {
        _errorMessage = 'Invalid code. Please try again.';
        _isVerifying = false;
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color myGreen = Color.fromRGBO(76, 175, 80, 0.8);

    return Scaffold(
      backgroundColor: Colors.white, // White background color
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.key, // Key Icon
                size: 80,
                color: myGreen, // Softer key color
              ),
              const SizedBox(height: 40),
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium, // Using headlineMedium
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Access Code',
                  labelStyle: const TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: myGreen.withOpacity(0.15), // Lighter fill color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ), // Rounded corners
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                ),
                keyboardType: TextInputType.text,
                maxLength: 10, // Limit input length
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the code provided by your doctor to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: _isVerifying ? null : _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: myGreen, // Lighter button color
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ), // Rounded button corners
                ),
                child: _isVerifying
                    ? const Text(
                        'Verifying...',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    : const Text(
                        'Access Questionnaire',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}