import 'package:flutter/material.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Model/spend_data.dart';
import 'package:get/get.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpendItem extends StatelessWidget {
  SpendItem({
    required this.data,
    this.onModifyClick,
    this.onDeleteClick,
  });

  SpendData data;
  Function()? onModifyClick;
  Function()? onDeleteClick;

  @override
  Widget build(BuildContext context) {
    String splitPeopleName = '';

    for (int i = 0; i < data.splitPeople.length; i++) {
      splitPeopleName += data.splitPeople[i].name;
      if (i < data.splitPeople.length - 1) {
        splitPeopleName += ", ";
      }
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorTheme().darkGrey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.spendName}",
                  style: TextStyleHelper().body2TitleWithNavy,
                  softWrap: true,
                ),
                Text(
                  "${data.paidPerson.name} ${"Paid".tr} ${data.cost}",
                  style: TextStyleHelper().body2TitleWithNavy,
                  softWrap: true,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${"SplitPeople".tr}: $splitPeopleName",
                    style: TextStyleHelper().body3TitleWithNavy,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.pen,
                    color: ColorTheme().navy,
                  ),
                  onPressed: () {
                    onModifyClick?.call();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: ColorTheme().navy,
                  ),
                  onPressed: () {
                    onDeleteClick?.call();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
