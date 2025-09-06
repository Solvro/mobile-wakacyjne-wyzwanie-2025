import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/exceptions/api_exception.dart";
import "../models/exceptions/general_exception.dart";
import "../models/exceptions/unauthorized_exception.dart";
import "../views/login_screen.dart";

void handleError(BuildContext context, WidgetRef ref, dynamic exception) {
  ApiException exp = GeneralException(0);

  if (exception is DioException && exception.error is ApiException) {
    exp = exception.error! as ApiException;
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exp.message)));
  }

  if (exp is UnauthorizedException) {
    if (context.mounted) {
      context.go(LoginScreen.route);
    }
  }
}
