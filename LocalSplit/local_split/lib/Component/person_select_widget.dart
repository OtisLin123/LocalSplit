import 'package:flutter/widgets.dart';
import 'package:local_split/Component/person_item.dart';
import 'package:local_split/Helper/text_style_helper.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:get/get.dart';

class PersonSelectWidget extends StatelessWidget {
  PersonSelectWidget({
    required this.selectPeople,
    required this.unselectPeople,
    this.selectOnDelect,
    this.unselectOnClick,
  });

  List<PersonData> selectPeople;
  List<PersonData> unselectPeople;
  Function(String id)? selectOnDelect;
  Function(String id)? unselectOnClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("SelectedPersoon".tr,
              style: TextStyleHelper().subTitleWithNavy),
        ),
        Expanded(
          flex: 1,
          child: ListView.separated(
            itemCount: selectPeople.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemBuilder: (context, index) {
              return SizedBox(
                height: 40,
                child: PersonItem(
                  showDelete: true,
                  data: selectPeople[index],
                  onDeleteClick: (key) {
                    selectOnDelect?.call(key);
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("UnselectPersoon".tr,
              style: TextStyleHelper().subTitleWithNavy),
        ),
        Expanded(
          flex: 1,
          child: ListView.separated(
            itemCount: unselectPeople.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemBuilder: (context, index) {
              return SizedBox(
                height: 40,
                child: PersonItem(
                  showDelete: false,
                  data: unselectPeople[index],
                  onClick: (key) {
                    unselectOnClick?.call(key);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
