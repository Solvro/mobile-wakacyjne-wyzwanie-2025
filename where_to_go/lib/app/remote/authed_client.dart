import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../features/auth/auth_notifier.dart";
import "retrofit_client.dart";

part "authed_client.g.dart";

@riverpod
Future<RestClient> authedClient(Ref ref) async {
  final state = ref.watch(authNotifierProvider);
  print("nowy klient");
  return ref.read(clientProvider(
    token: state.value?.token,
    onError: state.value?.token != null
        ? (error, handler) async {
            if (error.response?.statusCode == 401) {
              await ref.read(authNotifierProvider.notifier).attemptRefreshToken();
            }
            handler.next(error);
          }
        : null,
  ));
}
