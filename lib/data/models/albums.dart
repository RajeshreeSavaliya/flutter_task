import 'dart:convert';

List<Albums> albumsFromJson(String str) => List<Albums>.from(json.decode(str).map((x) {
  print("value of x");
  print(x);

  return Albums.fromJson(x);

}));

String albumsToJson(List<Albums> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Albums {
  int? userId;
  int? id;
  String? title;

  Albums({
    this.userId,
    this.id,
    this.title,
  });

  Albums copyWith({
    int? userId,
    int? id,
    String? title,
  }) =>
      Albums(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
    userId: json["userId"] as int,
    id: json["id"] as int,
    title: json["title"] as String,
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
  };
}
