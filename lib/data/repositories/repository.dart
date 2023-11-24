import 'package:flutter_task_m/data/models/albums.dart';
import 'package:flutter_task_m/data/services/api_client.dart';


class Repository {

  final ApiClient apiClient= ApiClient();

  Repository();

  static Repository getInstance() {
    return Repository();
  }

  Future<List<Albums>> getAlbums() async {
    try {
      String response = await apiClient.apiCallGet(ApiClient.ALBUMS);
      return albumsFromJson(response);
    } catch (e) {
      print("error" + e.toString());
      throw e;
    }
  }
}