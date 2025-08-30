import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../features/auth/auth_notifier.dart";
import "retrofit_client.dart";

part "authed_client.g.dart";

@riverpod
Future<RestClient> authedClient(Ref ref) async {
  final token = await ref.watch(authNotifierProvider.notifier).getToken();
  return ref.watch(clientProvider(token: token));
}
