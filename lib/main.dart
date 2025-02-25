import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cinco_linguagens/quiz_screen.dart';
import 'package:cinco_linguagens/background_shapes.dart';

void main() {
  runApp(const LoveQuizApp());
}

class LoveQuizApp extends StatelessWidget {
  const LoveQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love Quiz',
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  ThemeData _getTheme(String gender) {
    switch (gender) {
      case 'Homem':
        return ThemeData(
          primaryColor: const Color(0xFF87CEEB), // Azul claro
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF87CEEB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            headlineSmall: TextStyle(color: Color(0xFF87CEEB)),
          ),
          useMaterial3: true,
        );
      case 'Mulher':
        return ThemeData(
          primaryColor: const Color(0xFFFF69B4), // Rosa
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF69B4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            headlineSmall: TextStyle(color: Color(0xFFFF69B4)),
          ),
          useMaterial3: true,
        );
      case 'Outro':
        return ThemeData(
          primaryColor: const Color(0xFFFF0000), // Vermelho
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF0000),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            headlineSmall: TextStyle(color: Color(0xFFFF0000)),
          ),
          useMaterial3: true,
        );
      default:
        return ThemeData();
    }
  }

  List<Widget> _generateInitialShapes(BuildContext context) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const colors = [Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey];

    return List.generate(5, (index) {
      final size = 50 + random.nextDouble() * 100;
      return Positioned(
        top: random.nextDouble() * (screenHeight - size),
        left: random.nextDouble() * (screenWidth - size),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors[index].withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundShapes(gender: '', shapes: _generateInitialShapes(context)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Descubra sua linguagem do amor!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Theme(
                          data: _getTheme('Homem'),
                          child: const QuizScreen(gender: 'Homem'),
                        ),
                      ),
                    );
                  },
                  child: const Text('Homem'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Theme(
                          data: _getTheme('Mulher'),
                          child: const QuizScreen(gender: 'Mulher'),
                        ),
                      ),
                    );
                  },
                  child: const Text('Mulher'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Theme(
                          data: _getTheme('Outro'),
                          child: const QuizScreen(gender: 'Outro'),
                        ),
                      ),
                    );
                  },
                  child: const Text('Outro'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}