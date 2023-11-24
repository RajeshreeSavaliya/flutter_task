import 'dart:convert';

import 'package:hive/hive.dart';

List<Photos> photosFromJson(String str) => List<Photos>.from(json.decode(str).map((x) => Photos.fromJson(x)));

String photosToJson(List<Photos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Photos {
  @HiveField(0)
  int? albumId;
  @HiveField(1)
  int? id;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? thumbnailUrl;
  @HiveField(6)
  String? imageFile;

  Photos({this.albumId, this.id, this.title, this.url, this.thumbnailUrl, this.imageFile});

  Photos copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) =>
      Photos(
        albumId: albumId ?? this.albumId,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}

// Generated adapter code
@HiveType(typeId: 0)
class PhotosAdapter extends TypeAdapter<Photos> {
  @override
  final int typeId = 0;

  @override
  Photos read(BinaryReader reader) {
    return Photos(
      albumId: reader.read(),
      id: reader.read(),
      url: reader.read(),
      thumbnailUrl: reader.read(),
      imageFile: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Photos obj) {
    writer.write(obj.albumId);
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.url);
    writer.write(obj.thumbnailUrl);
    writer.write(obj.imageFile);
  }
}
