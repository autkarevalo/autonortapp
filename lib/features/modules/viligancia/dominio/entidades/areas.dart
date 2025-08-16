class Areas {
  String area;

  Areas({required this.area});

  factory Areas.fromJson(Map<String, dynamic> json) =>
      Areas(area: json["AREA"] ?? '');

  Map<String, dynamic> toJson() => {"AREA": area};
}
