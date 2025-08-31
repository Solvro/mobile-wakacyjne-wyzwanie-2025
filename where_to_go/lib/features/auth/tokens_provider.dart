import "package:riverpod/riverpod.dart";
import "authentication_repository_provider.dart";

final tokensProvider = FutureProvider<(String?, String?)?>((ref) async {
  final repo = ref.read(authenticationRepositoryProvider);
  return repo.readTokens();
});
