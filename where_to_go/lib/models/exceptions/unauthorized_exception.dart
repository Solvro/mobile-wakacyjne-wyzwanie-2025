import "api_exception.dart";

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super(statusCode: 401, message: "Wylogowano. Zaloguj się ponownie");
}
