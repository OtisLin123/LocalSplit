class PersonData {
  String name;
  String key;

  PersonData({
    required this.name,
    required this.key,
  });

  factory PersonData.fromJson(Map<String, dynamic> json) => PersonData(
        name: json["name"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
      };
}
