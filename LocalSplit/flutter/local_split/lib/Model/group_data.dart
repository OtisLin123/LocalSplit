import 'package:local_split/Model/person_data.dart';
import 'package:local_split/Model/spend_data.dart';

class GroupData {
  GroupData({
    required this.name,
    required this.date,
    required this.key,
    this.people = const [],
    this.spendData = const [],
  });
  String name;
  DateTime date;
  String key;
  List<PersonData> people;
  List<SpendData> spendData;

  void addSpendData(SpendData newData) {
    for (int i = 0; i < spendData.length; i++) {
      if (spendData[i].key == newData.key) {
        spendData[i] = newData;
        return;
      }
    }
    spendData = [...spendData, newData];
  }

  void removeSpendData(String spendDataKey) {
    for (int i = 0; i < spendData.length; i++) {
      if (spendData[i].key == spendDataKey) {
        spendData.removeAt(i);
        return;
      }
    }
  }

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        name: json["name"],
        date: DateTime.parse(json["date"]),
        key: json["key"],
        people: List<PersonData>.from(
            json["people"].map((x) => PersonData.fromJson(x))),
        spendData: List<SpendData>.from(json["spendData"].map((x) => SpendData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date.toString(),
        "key": key,
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
        "spendData": List<dynamic>.from(spendData.map((x) => x.toJson())),
      };
}
