part of 'error_handler.dart';

Future _serverErrorHandler(BuildContext context, ServerError error) async {
  return error.maybeWhen(
    tooManyRequests: (data) => getErrorMessage(context, data.message),
    badRequests: (data) => getErrorMessage(context, data.message),
    internalServerError: (data) => getErrorMessage(context, data.message),
    orElse: () => _showSomethingWentWrong(context),
  );
}
