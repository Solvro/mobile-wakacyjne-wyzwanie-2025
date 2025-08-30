import "dart:io";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../app/remote/authed_client.dart";
import "../../app/remote/retrofit_client.dart";
import "../photo_repository.dart";

part "photo_repository_impl.g.dart";

class PhotoRepositoryImpl implements PhotoRepository {
  final RestClient _client;

  PhotoRepositoryImpl(this._client);

  @override
  Future<String> uploadImage(File image) async {
    final uploadedImage = await _client.postImage(image);
    return uploadedImage.filename;
  }
}

@riverpod
Future<PhotoRepository> photoRepository(Ref ref) async {
  return PhotoRepositoryImpl(await ref.watch(authedClientProvider.future));
}
