import 'dart:convert';

import 'package:local_split/Model/person_data.dart';

PeopleModel peopleModelFromJson(String str) => PeopleModel.fromJson(json.decode(str));

String peopleModelToJson(PeopleModel data) => json.encode(data.toJson());

class PeopleModel {
    List<PersonData> people;

    PeopleModel({
        required this.people,
    });

    factory PeopleModel.fromJson(Map<String, dynamic> json) => PeopleModel(
        people: List<PersonData>.from(json["people"].map((x) => PersonData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
    };
}