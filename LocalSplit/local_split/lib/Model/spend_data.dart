import 'package:local_split/Model/person_data.dart';

class SpendData {
  SpendData({
    required this.key,
    this.spendName = "",
    required this.paidPerson,
    required this.splitPeople,
    required this.date,
    required this.cost,
  });
  String key;
  String spendName;
  PersonData paidPerson;
  List<PersonData> splitPeople;
  double cost;
  DateTime date;

  factory SpendData.fromJson(Map<String, dynamic> json) => SpendData(
        spendName: json["spendName"],
        date: DateTime.parse(json["date"]),
        key: json["key"],
        paidPerson: PersonData.fromJson(json["paidPerson"]),
        splitPeople: List<PersonData>.from(json["splitPeople"].map((x) => PersonData.fromJson(x))),
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() => {
        "spendName": spendName,
        "date": date.toString(),
        "key": key,
        "paidPerson": paidPerson.toJson(),
        "splitPeople": List<dynamic>.from(splitPeople.map((x) => x.toJson())),
        "cost": cost,
      };
}
