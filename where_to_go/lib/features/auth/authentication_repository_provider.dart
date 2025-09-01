import "package:riverpod/riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "authentication_repository.dart";

part "authentication_repository_provider.g.dart";

@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  // Return the concrete implementation directly so consumers can call its methods:
  return AuthenticationRepositoryImpl();
}
