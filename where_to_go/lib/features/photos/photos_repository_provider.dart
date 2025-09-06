import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../repositories/implementations/photos_repository_impl.dart";
import "../../repositories/photos_repository.dart";
import "../auth/http_provider.dart";

part "photos_repository_provider.g.dart";

@Riverpod(keepAlive: true)
Future<PhotosRepository> photosRepository(Ref ref) async {
  final dio = await ref.watch(clientDioProvider.future);

  return PhotosRepositoryImpl(dio);
}
