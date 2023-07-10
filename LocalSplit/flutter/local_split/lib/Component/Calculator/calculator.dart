import 'package:flutter/material.dart';
import 'package:local_split/Component/Calculator/calculator_controller.dart';

class Calculator extends StatefulWidget {
  Calculator({
    super.key,
    this.onDone,
    this.textEditController,
    this.calculatorController,
  });
  Function()? onDone;
  TextEditingController? textEditController;
  CalculatorController? calculatorController;
  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late TextEditingController textEditController;
  late CalculatorController calculatorController;
  bool needClearInput = false;

  @override
  void initState() {
    textEditController = widget.textEditController ?? TextEditingController();
    calculatorController = widget.calculatorController ?? CalculatorController();

    calculatorController.resultNotifier.addListener(() {
      setState(() {
        textEditController.text = calculatorController.resultString;
      });
    });

    calculatorController.calculateOperatorNotifier.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildNumberButton(
                  text: "7",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "8",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "9",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: "X",
                  flex: 1,
                  onPressed: () {
                    if (calculatorController.calculateOperator ==
                        CalculatorOperator.none) {
                      calculatorController.result =
                          double.parse(textEditController.text);
                    }
                    calculatorController.calculateOperator =
                        CalculatorOperator.multiplication;
                    needClearInput = true;
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: "/",
                  flex: 1,
                  onPressed: () {
                    if (calculatorController.calculateOperator ==
                        CalculatorOperator.none) {
                      calculatorController.result =
                          double.parse(textEditController.text);
                    }
                    calculatorController.calculateOperator =
                        CalculatorOperator.division;
                    needClearInput = true;
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildNumberButton(
                  text: "4",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "5",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "6",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: "-",
                  flex: 1,
                  onPressed: () {
                    if (calculatorController.calculateOperator ==
                        CalculatorOperator.none) {
                      calculatorController.result =
                          double.parse(textEditController.text);
                    }
                    calculatorController.calculateOperator =
                        CalculatorOperator.subtraction;
                    needClearInput = true;
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                    text: "AC",
                    flex: 1,
                    onPressed: () {
                      // textEditController.text = '';
                      calculatorController.clear();
                    }),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildNumberButton(
                  text: "1",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "2",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "3",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: "+",
                  flex: 1,
                  onPressed: () {
                    if (calculatorController.calculateOperator ==
                        CalculatorOperator.none) {
                      calculatorController.result =
                          double.parse(textEditController.text);
                    }
                    calculatorController.calculateOperator =
                        CalculatorOperator.addition;
                    needClearInput = true;
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: "<-",
                  flex: 1,
                  onPressed: () {
                    if (textEditController.text.isEmpty ||
                        textEditController.text == "0") {
                      return;
                    }

                    textEditController.text = textEditController.text
                        .substring(0, textEditController.text.length - 1);
                    if (textEditController.text.isEmpty) {
                      textEditController.text = "0";
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildNumberButton(
                  text: "00",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildNumberButton(
                  text: "0",
                  flex: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                _buildButton(
                  text: ".",
                  flex: 1,
                  onPressed: () {
                    if (textEditController.text.contains(".")) {
                      return;
                    }
                    textEditController.text = "${textEditController.text}.";
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Visibility(
                  visible: calculatorController.calculateOperator !=
                      CalculatorOperator.none,
                  child: _buildButton(
                    text: "=",
                    flex: 2,
                    onPressed: () {
                      calculatorController.num =
                          double.parse(textEditController.text);
                      calculatorController.calculate();
                    },
                  ),
                ),
                Visibility(
                  visible: calculatorController.calculateOperator ==
                      CalculatorOperator.none,
                  child: _buildButton(
                    text: "OK",
                    flex: 2,
                    onPressed: () {
                      widget.onDone?.call();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton({
    required String text,
    required int flex,
  }) {
    return _buildButton(
      text: text,
      flex: flex,
      onPressed: () {
        if (needClearInput ||
            textEditController.text.isNotEmpty &&
                !textEditController.text.contains(".") &&
                textEditController.text[0] == "0") {
          textEditController.text = text;
        } else {
          textEditController.text = textEditController.text + text;
        }

        if (needClearInput) {
          needClearInput = false;
        }
      },
    );
  }

  Widget _buildButton({
    required String text,
    required int flex,
    Function()? onPressed,
  }) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
