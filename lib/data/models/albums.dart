import 'dart:convert';

import 'package:hive/hive.dart';

List<Albums> albumsFromJson(String str) => List<Albums>.from(json.decode(str).map((x) => Albums.fromJson(x)));

String albumsToJson(List<Albums> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class Albums {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  int? id;
  @HiveField(2)
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

// Generated adapter code
@HiveType(typeId: 1)
class AlbumsAdapter extends TypeAdapter<Albums> {
  @override
  final int typeId = 1;

  @override
  Albums read(BinaryReader reader) {
    return Albums(
      userId: reader.read(),
      id: reader.read(),
      title: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Albums obj) {
    writer.write(obj.userId);
    writer.write(obj.id);
    writer.write(obj.title);
  }
}
