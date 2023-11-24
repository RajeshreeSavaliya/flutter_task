import 'package:flutter_task_m/data/models/albums.dart';
import 'package:flutter_task_m/data/models/photos.dart';
import 'package:flutter_task_m/data/services/api_client.dart';
import 'package:hive/hive.dart';

class Repository {
  final ApiClient apiClient = ApiClient();
  static const String _photosBox = "photosBox";
  static const String _albumsBox = "albumsBox";

  Repository();

  Future<List<Albums>> getAlbums() async {
    try {
      final box = await openAlbumsBox();
      if (box.isNotEmpty) {
        return getAlbumsFromDB();
      } else {
        dynamic response = await apiClient.apiCallGet(ApiClient.albums);
        List<Albums> albums = albumsFromJson(response);
        await box.clear();
        await box.addAll(albums);
        closeHiveBox(box);
        return albums;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Albums>> getAlbumsFromDB() async {
    try {
      final Box<Albums> box;
      if (!Hive.isBoxOpen(_albumsBox)) {
        box = await openAlbumsBox();
      } else {
        box = Hive.box<Albums>(_albumsBox);
      }
      final List<Albums> albums = box.values.toList();
      await closeHiveBox(box);
      return albums;
    } catch (e) {
      return <Albums>[];
    }
  }

  Future<List<Photos>> getPhotos() async {
    try {
      final box = await openPhotosBox();
      if (box.isNotEmpty) {
        return getPhotosFromDB();
      } else {
        dynamic response = await apiClient.apiCallGet(ApiClient.photos);
        List<Photos> photos = photosFromJson(response);
        await box.putAll(Map.fromIterable(photos, key: (photo) => photo.id));
        await closeHiveBox(box);
        return photos;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Photos>> getPhotosFromDB() async {
    try {
      final Box<Photos> box;
      if (!Hive.isBoxOpen(_photosBox)) {
        box = await openPhotosBox();
      } else {
        box = Hive.box<Photos>(_photosBox);
      }
      final List<Photos> photos = box.values.toList();
      await closeHiveBox(box);
      return photos;
    } catch (e) {
      return <Photos>[];
    }
  }

  Future<Box<Photos>> openPhotosBox() async {
    final box = await Hive.openBox<Photos>(_photosBox);
    return box;
  }

  Future<Box<Albums>> openAlbumsBox() async {
    final box = await Hive.openBox<Albums>(_albumsBox);
    return box;
  }

  Future<void> closeHiveBox(Box box) async {
    if (box.isOpen) {
      // await box.close();
    }
  }
}
