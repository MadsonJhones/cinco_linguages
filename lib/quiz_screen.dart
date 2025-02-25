import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cinco_linguagens/models/question.dart';
import 'package:cinco_linguagens/result_screen.dart';
import 'package:cinco_linguagens/background_shapes.dart';

class QuizScreen extends StatefulWidget {
  final String gender;

  const QuizScreen({super.key, required this.gender});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  Map<String, int> scores = {'A': 0, 'B': 0, 'C': 0, 'D': 0, 'E': 0};
  String? selectedOption;
  late List<Widget> currentShapes;
  late List<Question> shuffledQuestions;

  @override
  void initState() {
    super.initState();
    // Embaralhar as perguntas no início
    shuffledQuestions = List.from(questions)..shuffle(Random());
    // Inicializar as formas após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentShapes = _generateShapes();
      });
    });
  }

  List<Widget> _generateShapes() {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Color> colors;
    switch (widget.gender) {
      case 'Homem':
        colors = [
          const Color(0xFF1E3A8A), // Azul escuro
          const Color(0xFF0F3D0F), // Verde escuro
          const Color(0xFF4B4B4B), // Cinza escuro
          const Color(0xFF2F2F2F), // Quase preto
          const Color(0xFF5A2E2E), // Marrom escuro
        ];
        break;
      case 'Mulher':
        colors = [
          const Color(0xFFFF69B4), // Rosa
          const Color(0xFFFFA500), // Laranja
          const Color(0xFFFFD700), // Amarelo
          const Color(0xFFDC143C), // Vermelho quente
          const Color(0xFFFFA07A), // Salmão
        ];
        break;
      case 'Outro':
        colors = [
          const Color(0xFFFF0000), // Vermelho vibrante
          const Color(0xFF8A2BE2), // Roxo vibrante
          const Color(0xFF00FF00), // Verde limão
          const Color(0xFFFF00FF), // Magenta
          const Color(0xFFFF4500), // Laranja forte
        ];
        break;
      default:
        colors = [Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey];
    }

    return List.generate(5, (index) {
      final size = 50 + random.nextDouble() * 100;
      final shapeType = random.nextInt(2); // 0 ou 1 para cada gênero

      Widget shape;
      if (widget.gender == 'Homem') {
        shape = shapeType == 0
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              )
            : Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
      } else if (widget.gender == 'Mulher') {
        shape = shapeType == 0
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              )
            : CustomPaint(
                size: Size(size, size),
                painter: TrianglePainter(colors[index].withOpacity(0.2)),
              );
      } else {
        shape = shapeType == 0
            ? Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors[index].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              )
            : CustomPaint(
                size: Size(size, size),
                painter: StarPainter(colors[index].withOpacity(0.2)),
              );
      }

      return Positioned(
        top: random.nextDouble() * (screenHeight - size),
        left: random.nextDouble() * (screenWidth - size),
        child: shape,
      );
    });
  }

  void nextQuestion() {
    if (selectedOption != null) {
      setState(() {
        if (selectedOption == shuffledQuestions[currentQuestionIndex].option1) {
          scores[shuffledQuestions[currentQuestionIndex].language1] =
              scores[shuffledQuestions[currentQuestionIndex].language1]! + 1;
        } else {
          scores[shuffledQuestions[currentQuestionIndex].language2] =
              scores[shuffledQuestions[currentQuestionIndex].language2]! + 1;
        }

        if (currentQuestionIndex < shuffledQuestions.length - 1) {
          currentQuestionIndex++;
          selectedOption = null;
          currentShapes = _generateShapes(); // Atualiza o fundo
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(scores: scores, gender: widget.gender),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = shuffledQuestions[currentQuestionIndex];
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta ${currentQuestionIndex + 1}/${shuffledQuestions.length}'),
        backgroundColor: theme.primaryColor,
        elevation: 0,
      ),
      body: currentShapes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                BackgroundShapes(gender: widget.gender, shapes: currentShapes),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          question.context,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        RadioListTile<String>(
                          title: Text(
                            question.option1,
                            style: const TextStyle(color: Colors.black87),
                          ),
                          value: question.option1,
                          activeColor: theme.primaryColor,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(
                            question.option2,
                            style: const TextStyle(color: Colors.black87),
                          ),
                          value: question.option2,
                          activeColor: theme.primaryColor,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: selectedOption == null ? null : nextQuestion,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Próxima'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}