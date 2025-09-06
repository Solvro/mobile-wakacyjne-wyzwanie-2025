import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../models/exceptions/general_exception.dart";
import "../../models/exceptions/unauthorized_exception.dart";
import "../../utils/paths.dart";
import "repository_providers.dart";

part "http_provider.g.dart";

@Riverpod(keepAlive: true)
Future<Dio> clientDio(Ref ref) async {
  final dio = Dio(BaseOptions(
    baseUrl: Paths.apiPath,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final accessToken = await ref.read(accessTokenProvider.future);

      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }

      return handler.next(options);
    },
    onError: (error, handler) {
      final statusCode = error.response?.statusCode;

      if (statusCode == 401) {
        handler.reject(DioException(error: UnauthorizedException(), requestOptions: error.requestOptions));
      } else if (statusCode != null && ![200, 201, 204].contains(statusCode)) {
        handler.reject(DioException(error: GeneralException(statusCode), requestOptions: error.requestOptions));
      }
    },
  ));

  return dio;
}
