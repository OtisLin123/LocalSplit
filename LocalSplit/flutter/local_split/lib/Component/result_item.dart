import 'package:flutter/material.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:get/get.dart';

class ResultItem extends StatelessWidget {
  ResultItem({
    super.key,
    required this.creditor,
    required this.debtor,
    required this.cost,
  });

  String creditor;
  String debtor;
  double cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorTheme().mediumGrey,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "$debtor ${"NeedPayTo".tr} $creditor  $cost",
          style: TextStyleHelper().contentTitleWithNavy,
        ),
      ),
    );
  }
}
