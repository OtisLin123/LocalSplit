import 'package:flutter/material.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_split/Theme/color_theme.dart';

class PersonItem extends StatelessWidget {
  PersonItem({
    super.key,
    required this.data,
    this.onClick,
    this.onDeleteClick,
    this.showDelete = true,
  });

  PersonData data;
  Function(String key)? onClick;
  Function(String key)? onDeleteClick;
  bool showDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call(data.key);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    data.name,
                    style: TextStyleHelper().contentTitleWithNavy,
                  ),
                ),
                if (showDelete)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        size: constraints.maxHeight - 20,
                        color: ColorTheme().navy,
                      ),
                      onPressed: () {
                        onDeleteClick?.call(data.key);
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
