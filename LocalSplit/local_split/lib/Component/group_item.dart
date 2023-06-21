import 'package:flutter/material.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_split/Theme/color_theme.dart';

class GroupItem extends StatelessWidget {
  GroupItem({
    super.key,
    required this.title,
    required this.groupKey,
    this.onClick,
    this.onModifyClick,
  });

  String title;
  String groupKey;
  Function(String key)? onClick;
  Function(String key)? onModifyClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call(groupKey);
      },
      child: Stack(
        children: [
          _buildBackground(),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildTitle(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _buildModifyButton(),
          )
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        title,
        style: TextStyleHelper().titleWithWhite,
      ),
    );
  }

  Widget _buildModifyButton() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: IconButton(
        icon: Icon(
          FontAwesomeIcons.pen,
          color: ColorTheme().navy,
        ),
        onPressed: () {
          onModifyClick?.call(groupKey);
        },
      ),
    );
  }
}
