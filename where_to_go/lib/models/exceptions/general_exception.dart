import "api_exception.dart";

class GeneralException extends ApiException {
  GeneralException(int statusCode) : super(statusCode: statusCode, message: "Wystąpił błąd. Sróbuj ponownie");
}
