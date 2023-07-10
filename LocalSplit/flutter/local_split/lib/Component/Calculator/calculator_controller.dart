import 'package:flutter/foundation.dart';

enum CalculatorOperator {
  none,
  addition,
  subtraction,
  multiplication,
  division,
}

class CalculatorController {
  CalculatorController({
    double? result,
  }) {
    calculateOperator = CalculatorOperator.none;
    resultNotifier.value = result ?? 0;
  }

  ValueNotifier<double> resultNotifier = ValueNotifier<double>(0.0);
  set result(double value) {
    resultNotifier.value = value;
    resultNotifier.notifyListeners();
  }

  double get result => resultNotifier.value;
  String get resultString => result.toString().replaceAll(RegExp(r"([.]*0*$)"), "");

  ///The number can be addend, subtrahend, multiplier, divisor.
  late double num;

  ///Next operatpr.
  ValueNotifier<CalculatorOperator> calculateOperatorNotifier =
      ValueNotifier<CalculatorOperator>(CalculatorOperator.none);
  set calculateOperator(CalculatorOperator operator) =>
      calculateOperatorNotifier.value = operator;
  CalculatorOperator get calculateOperator => calculateOperatorNotifier.value;

  void calculate() {
    if (calculateOperator == CalculatorOperator.none) {
      return;
    }

    if (calculateOperator == CalculatorOperator.addition) {
      result += num;
    } else if (calculateOperator == CalculatorOperator.subtraction) {
      result -= num;
    } else if (calculateOperator == CalculatorOperator.multiplication) {
      result *= num;
    } else if (calculateOperator == CalculatorOperator.division) {
      result /= num;
    }
    _clearOperatorAndNum();
  }

  void clear() {
    result = 0;
    _clearOperatorAndNum();
  }

  void _clearOperatorAndNum() {
    num = 0;
    calculateOperator = CalculatorOperator.none;
  }
}
