import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../features/auth/repository/user_repository.dart";
import "../authed_client.dart";
import "../retrofit_client.dart";

part "user_repository_impl.g.dart";

class UserRepositoryImpl implements UserRepository {
  final RestClient _client;

  UserRepositoryImpl(this._client);

  @override
  Future<String> getUserEmail() async {
    final response = await _client.me();
    return response.email;
  }
}

@riverpod
Future<UserRepository> userRepository(Ref ref) async {
  return UserRepositoryImpl(await ref.watch(authedClientProvider.future));
}
