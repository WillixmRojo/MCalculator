import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:math_expressions/math_expressions.dart";
import "button_widget.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> buttonTexts = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '00',
    '0',
    '.',
    '=',
  ];

  String questionText = '';
  String answerText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.yellow,
            Colors.orange,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Center(
            child: Container(
                width: 375,
                // height: 750,
                margin: const EdgeInsets.symmetric(vertical: 50),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                questionText,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                              Text(
                                answerText,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      itemCount: buttonTexts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          _buttonTap(buttonTexts[index]);
                        },
                        child: ButtonWidget(text: buttonTexts[index]),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  )
                ])),
          )),
    );
  }

  void _buttonTap(String textButton) {
    if (textButton == 'DEL') {
      if (questionText != '') {
        setState(() {
          questionText = questionText.substring(0, questionText.length - 1);
        });
      }
    } else if (textButton == 'C') {
      setState(() {
        questionText = '';
        answerText = '';
      });
    } else if (textButton == '=') {
      if (questionText != '') {
        _calculate(questionText);
      }
    } else {
      setState(() {
        questionText += textButton;
      });
    }
  }

  void _calculate(String text) {
    String replacedText = text.replaceAll('x', '*');

    Parser p = Parser();

    Expression exp = p.parse(replacedText);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      answerText = eval.toStringAsFixed(2);
    });
  }
}
