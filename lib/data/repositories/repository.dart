import 'package:flutter_task_m/data/models/albums.dart';
import 'package:flutter_task_m/data/models/photos.dart';
import 'package:flutter_task_m/data/services/api_client.dart';
import 'package:hive/hive.dart';

class Repository {
  final ApiClient apiClient = ApiClient();
  late final Box box;

  Repository();


  Future<List<Albums>> getAlbums() async {
    openBox();
    try {
      dynamic response = await apiClient.apiCallGet(ApiClient.ALBUMS);
      List<Albums> albums = albumsFromJson(response);
      box.put("albumsList", albums);
      print("images data: >>>  ${box.get("albumsList")}");
      return albums;
    } catch (e) {
      print("error" + e.toString());
      throw e;
    }
  }

  Future<List<Photos>> getPhotos() async {
    openBox();
    try {
      dynamic response = await apiClient.apiCallGet(ApiClient.PHOTOS);
      List<Photos> photos = photosFromJson(response);
      box.put("photosList", photos);
      print("images data: >>>  ${box.get("photosList")}");
      return photos;
    } catch (e) {
      print("error" + e.toString());
      throw e;
    }
  }

  Future<void> openBox() async {
    box = await Hive.openBox('Photos');
  }
}
