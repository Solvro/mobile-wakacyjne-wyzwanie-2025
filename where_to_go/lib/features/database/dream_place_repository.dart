import "dart:typed_data";
import "package:dio/dio.dart";
import "dream_place.dart";
import "../auth/tokens_provider.dart";
import "package:riverpod/riverpod.dart";

class DreamPlaceRepository {
  // Use a file-backed DB instead of in-memory so data persists across restarts

  final dio = Dio(BaseOptions(baseUrl: "https://backend-api.w.solvro.pl/"));

  final Map<String, Uint8List> _photoCache = {};

  Future<void> addDreamPlace(DreamPlace place) async {
    await dio.post("/places", data: {
      "name": place.name,
      "description": place.description,
      "imageUrl": place.imageUrl,
      "isFavourite": place.isFavourite,
    });
  }

  Future<List<dynamic>> getAllDreamPlaces(Ref ref) async {
    print("entering getAllDreamPlaces");

    final tokens = await ref.read(tokensProvider.future);
    final accessToken = tokens.$1;
    if (accessToken == null) {
      print("getAllDreamPlaces: no access token -> returning empty list");
      return <dynamic>[];
    }

    dio.options.headers = {
      "Authorization": "Bearer $accessToken",
    };

    Response<dynamic>? response;
    try {
      // don't force a List<> type here — let the response be dynamic and inspect it
      response = await dio.get(
        "/places",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
    } on DioException catch (dioErr) {
      return <dynamic>[];
    } catch (e) {
      return <dynamic>[];
    }

    if (response.statusCode == 200) {
      final data = response.data;
      return [data];
    }

    return <dynamic>[];
  }

  Future<dynamic> updateDreamplace(DreamPlace place) async {
    final response = await dio.put("/places/${place.id}", data: {
      "name": place.name,
      "description": place.description,
      "imageUrl": place.imageUrl,
      "isFavourite": place.isFavourite,
    });
  }

  Future<dynamic> toggleFavourite(int id) async {
    final place = await dio.get("/places/$id");
    if (place.statusCode == 200) {
      final bool isFavourite = !(place.data["isFavourite"] as bool);
      await dio.put("/places/$id", data: {
        "name": place.data["name"],
        "description": place.data["description"],
        "imageUrl": place.data["imageUrl"],
        "isFavourite": isFavourite,
      });
    }
  }

  Future<dynamic> deleteDreamPlace(int id) async {
    await dio.delete("/places/$id");
  }

  Future<Uint8List?> getPhotoBytes(String? filename, String? accessToken) async {
    if (filename == null || filename.isEmpty) return null;

    // return cached bytes if available
    if (_photoCache.containsKey(filename)) {
      return _photoCache[filename];
    }

    final path = "/photos/${Uri.encodeComponent(filename)}";
    print("getPhotoBytes: requesting $path");

    try {
      final resp = await dio.get<List<int>>(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          headers: accessToken != null ? {"Authorization": "Bearer $accessToken"} : null,
        ),
      );

      final body = resp.data;
      if (body == null) {
        print("getPhotoBytes: empty body");
        return null;
      }

      final bytes = Uint8List.fromList(body);
      // cache result
      _photoCache[filename] = bytes;
      return bytes;
    } on DioException catch (e) {
      print("getPhotoBytes: DioException type=${e.type} status=${e.response?.statusCode} message=${e.message}");
    } catch (e, st) {
      print("getPhotoBytes: unexpected $e\n$st");
    }
    return null;
  }

  void clearPhotoCache() => _photoCache.clear();
}
