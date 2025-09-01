import "package:riverpod/riverpod.dart";
import "authentication_repository_provider.dart";

final tokensProvider = FutureProvider<(String?, String?)>((ref) async {
  final authRepo = ref.read(authenticationRepositoryProvider);
  final persisted = await authRepo.readTokens(); // (String? access, String? refresh)
  final access = persisted.$1;
  final refresh = persisted.$2;

  print("Tokens available in the provider: $persisted");

  // nothing persisted
  if (access == null || refresh == null) return (null, null);

  try {
    final fresh = await authRepo.refreshToken(refresh); // (access, refresh)
    print("fresh accessToken: $fresh");
    // persist fresh tokens and return them
    await authRepo.saveTokens(fresh! as String, refresh);
    return (fresh as String, refresh);
  } catch (e) {
    print("Error refreshing token: $e");
    // refresh failed — delete persisted tokens and return null
    await authRepo.deleteTokens();
    return (null, null);
  }
});
