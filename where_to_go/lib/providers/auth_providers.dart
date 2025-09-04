//providers/auth_providers.dart
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../models/authentication_tokens.dart";
import "../repositories/authentication_repository.dart";
import "../repositories/local_authentication_repository.dart";
import "../repositories/remote_authentication_repository.dart";

// 1. Provider dla zewnętrznych zależności
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// 2. Provider dla repozytoriów
final localAuthRepoProvider = Provider<LocalAuthenticationRepository>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return LocalAuthenticationRepository(secureStorage: secureStorage);
});

final remoteAuthRepoProvider = Provider<RemoteAuthenticationRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final localAuthRepo = ref.watch(localAuthRepoProvider);
  return RemoteAuthenticationRepository(dio: dio, localAuthRepo: localAuthRepo);
});

// 3. Główny provider AuthenticationRepository
final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final localAuthRepo = ref.watch(localAuthRepoProvider);
  final remoteAuthRepo = ref.watch(remoteAuthRepoProvider);
  return AuthenticationRepository(
    localAuthenticationRepository: localAuthRepo,
    remoteAuthenticationRepository: remoteAuthRepo,
  );
});

// 4. Provider stanu autentykacji (uproszczony)
final authStateProvider = FutureProvider<bool>((ref) async {
  final authRepo = ref.watch(authRepositoryProvider);
  await authRepo.initialize();
  return authRepo.isLoggedIn;
});

// 5. Provider dla tokenów (opcjonalnie)
final tokensProvider = Provider<AuthenticationTokens?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.tokens;
});
