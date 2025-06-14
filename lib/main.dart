import 'package:flutter/material.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/questionnaire_screen.dart';
import 'package:myapp/confirmation_screen.dart';
import 'package:myapp/question.dart'; // Import Question and QuestionType

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color myGreen = Color.fromRGBO(76, 175, 80, 0.8);
    return MaterialApp(
      title: 'RecoverWell',
      theme: ThemeData(
        // Define a softer and milder color palette focusing on light blue and greyish tones
        colorScheme: ColorScheme.light( // Use light color scheme
          primary: myGreen, // Very light blue - Primary
          onPrimary: Colors.white, // Dark text on primary for better contrast
          primaryContainer: myGreen.withValues(
            alpha: 0.9,
            red: (myGreen.r * 255.0).round() & 0xff as double,
            green: (myGreen.g * 255.0).round() & 0xff as double,
            blue: (myGreen.b * 255.0).round() & 0xff as double,
          ), // Even lighter blue - Primary container
          onPrimaryContainer: Colors.white, // Dark text on primary container
          secondary: myGreen.withValues(
            alpha: 0.8,
            red: (myGreen.r * 255.0).round() & 0xff as double,
            green: (myGreen.g * 255.0).round() & 0xff as double,
            blue: (myGreen.b * 255.0).round() & 0xff as double,
          ), // Light greyish blue - Secondary
          onSecondary: Colors.white, // Dark text on secondary
          secondaryContainer: myGreen.withValues(
            alpha: 0.7,
            red: (myGreen.r * 255.0).round() & 0xff as double,
            green: (myGreen.g * 255.0).round() & 0xff as double,
            blue: (myGreen.b * 255.0).round() & 0xff as double,
          ), // Lighter greyish blue - Secondary container
          onSecondaryContainer: Colors.white, // Dark text on secondary container
          tertiary: myGreen, // A calming green - Tertiary (for accents/success)
          onTertiary: Colors.white, // White text on tertiary
          surface: Colors.white, // White for cards and surfaces
          onSurface: Colors.black87, // Dark text on background
          error: Colors.redAccent, // Red for error states
          onError: Colors.white, // White text on error color
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(76, 175, 80, 0.8), // Use primary color
          foregroundColor: Colors.white, // Dark text for better contrast
          elevation: 1.0, // Slightly less elevation
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white), // Consistent icon color
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Large
          displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Medium
          displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Small
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Large
          headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Medium
          headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87), // Headline Small
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black87), // Title Large
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87), // Title Medium
          titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black87), // Title Small
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87), // Body Large
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87), // Body Medium (default)
          bodySmall: TextStyle(fontSize: 12.0, color: Colors.black87), // Body Small
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold), // Label Large (buttons)
          labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), // Label Medium
          labelSmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold), // Label Small
        ), // Defined a more complete text theme with consistent color

        // Define button themes for a modern look
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: myGreen, // Use tertiary color (green) for elevated buttons
            foregroundColor: Colors.white, // White text on tertiary color
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Rounded corners
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0), // Increased padding
            elevation: 2.0,
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), // Button text style
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: myGreen, // Blue text for text buttons
             textStyle: const TextStyle(fontSize: 16.0), // Button text style
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: myGreen, // Blue text for outlined buttons
            side: const BorderSide(color: Color.fromRGBO(76, 175, 80, 0.8)), // Blue border for outlined buttons (Added const)
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Rounded corners
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0), // Increased padding
            elevation: 0,
             textStyle: const TextStyle(fontSize: 16.0), // Button text style
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
           filled: true,
           fillColor: Colors.white,
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide.none,
           ),
           contentPadding: const EdgeInsets.symmetric(
               horizontal: 16.0, vertical: 14.0), // Increased padding
           hintStyle: const TextStyle(color: Colors.black54), // Hint text color
         ), // Added input decoration theme for consistency
         cardTheme: CardThemeData(
           elevation: 2.0,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
           margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0), // Card margin
         ), // Fixed CardTheme to CardThemeData
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), // Added const
        '/confirmation': (context) => const ConfirmationScreen(), // Added const, Keep confirmation route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/questionnaire') {
          // Replace with your actual logic to fetch questions
          final dummyQuestions = [
            Question(
              text: 'Wie beurteilen Sie Ihre Fähigkeit, mit der Hand zu schreiben oder Knöpfe zu schließen?',
              type: QuestionType.multipleChoice,
              options: [
                'Normal',
                'Schreiben etwas eingeschränkt, aber möglich; Manschettenknöpfe können geknöpft werden',
                'Schreiben möglich, wenngleich sehr ungeschickt; große Knöpfe können geknöpft werden',
                'Fähig, sich selbst mit Löffel und Gabel zu ernähren, jedoch ungeschickt',
                'Unfähig, selbst mit Löffel und Gabel zu essen; unfähig, selbst große Knöpfe zu knöpfen',
              ],
            ),
            Question(
              text: 'Wie beurteilen Sie Ihre motorische Funktion der unteren Extremitäten?',
              type: QuestionType.multipleChoice,
              options: [
                'Normal',
                'Rasches Gehen möglich, jedoch etwas unsicheres Gangbild',
                'Treppaufgehen ohne Unterstützung; Treppabgehen nur mit Unterstützung möglich',
                'Fähig, auf ebenem Untergrund frei zu gehen; Treppensteigen nur mit Unterstützung',
                'Fähig, ohne Unterstützung zu gehen, jedoch unsicheres Gangbild',
                'Unfähig, selbst auf ebenem Untergrund ohne Gehhilfe zu gehen',
                'Fähig, aufzustehen, jedoch nicht zu gehen',
                'Nicht in der Lage, aufzustehen und zu gehen',
              ],
            ),
            Question(
              text: 'Wie beurteilen Sie die Sensibilität Ihrer oberen Extremitäten?',
              type: QuestionType.multipleChoice,
              options: [
                'Normal',
                'Taubheitsgefühl ohne sensibles Defizit',
                'Bis 40%ige Sensibilitätsminderung und/oder mäßige Schmerzen oder Taubheit',
                'Bis 50%ige Sensibilitätsminderung und/oder erhebliche Schmerzen oder Taubheit',
                'Vollständiger Verlust der Berührungs- und Schmerzempfindung',
              ],
            ),
            Question(
              text: 'Wie beurteilen Sie Ihre Blasenfunktion?',
              type: QuestionType.multipleChoice,
              options: [
                'Normal',
                'Verzögerte Blasenentleerung und/oder Pollakisurie',
                'Gefühl der unvollständigen Blasenentleerung und/oder Nachtröpfeln und/oder spärlicher Urinstrahl und/oder nur teilweise erhaltene Kontinenz',
                'Harnretention und/oder Inkontinenz',
              ],
            ),
            Question(
              text: 'Bitte beschreiben Sie eventuelle Schmerzen oder Taubheitsgefühle in eigenen Worten.',
              type: QuestionType.shortText,
              placeholder: 'z. B. Art, Dauer, Ausstrahlung',
            ),

          ];
          return MaterialPageRoute(
            builder: (context) => QuestionnaireScreen(questions: dummyQuestions),
          );
        }
        // Handle other routes
        return null;
      },
    );
  }
}
