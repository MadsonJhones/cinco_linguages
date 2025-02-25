import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:cinco_linguagens/background_shapes.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, int> scores;
  final String gender;

  const ResultScreen({super.key, required this.scores, required this.gender});

  Map<String, double> calculatePercentages() {
    final total = scores.values.reduce((a, b) => a + b);
    return {
      'Palavras de Afirmação': (scores['A']! / total) * 100,
      'Tempo de Qualidade': (scores['B']! / total) * 100,
      'Receber Presentes': (scores['C']! / total) * 100,
      'Atos de Serviço': (scores['D']! / total) * 100,
      'Toque Físico': (scores['E']! / total) * 100,
    };
  }

  String getPrimaryLanguage() {
    final languages = {
      'A': 'Palavras de Afirmação',
      'B': 'Tempo de Qualidade',
      'C': 'Receber Presentes',
      'D': 'Atos de Serviço',
      'E': 'Toque Físico',
    };
    var highest = scores.entries.reduce((a, b) => a.value > b.value ? a : b);
    return languages[highest.key]!;
  }

  Color getPrimaryColor() {
    final colors = {
      'A': Colors.red,
      'B': Colors.blue,
      'C': Colors.yellow,
      'D': Colors.purple,
      'E': Colors.green,
    };
    var highest = scores.entries.reduce((a, b) => a.value > b.value ? a : b);
    return colors[highest.key]!;
  }

  List<Widget> _generateShapes(BuildContext context) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Color> colors;
    switch (gender) {
      case 'Homem':
        colors = [
          const Color(0xFF1E3A8A),
          const Color(0xFF0F3D0F),
          const Color(0xFF4B4B4B),
          const Color(0xFF2F2F2F),
          const Color(0xFF5A2E2E),
        ];
        break;
      case 'Mulher':
        colors = [
          const Color(0xFFFF69B4),
          const Color(0xFFFFA500),
          const Color(0xFFFFD700),
          const Color(0xFFDC143C),
          const Color(0xFFFFA07A),
        ];
        break;
      case 'Outro':
        colors = [
          const Color(0xFFFF0000),
          const Color(0xFF8A2BE2),
          const Color(0xFF00FF00),
          const Color(0xFFFF00FF),
          const Color(0xFFFF4500),
        ];
        break;
      default:
        colors = [Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey];
    }

    return List.generate(5, (index) {
      final size = 50 + random.nextDouble() * 100;
      final shapeType = random.nextInt(2);

      Widget shape;
      if (gender == 'Homem') {
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
      } else if (gender == 'Mulher') {
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

  @override
  Widget build(BuildContext context) {
    final dataMap = calculatePercentages();
    final colorList = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.green,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          BackgroundShapes(gender: gender, shapes: _generateShapes(context)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Sua linguagem de amor é ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: getPrimaryLanguage(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: getPrimaryColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Veja como suas preferências se distribuem:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                PieChart(
                  dataMap: dataMap,
                  colorList: colorList,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.bottom,
                    legendTextStyle: TextStyle(color: Colors.black87),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    chartValueStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar ao Início'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}