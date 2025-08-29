import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../features/auth/auth_notifier.dart";
import "retrofit_client.dart";

part "authed_client.g.dart";

@riverpod
RestClient authedClient(Ref ref) {
  final auth = ref.watch(authNotifierProvider);
  return ref.watch(clientProvider(token: auth.value));
}
