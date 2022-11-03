import 'package:flutter_lyra_platform_interface/flutter_lyra_platform_interface.dart';

import '../models/errors.dart';

/// method used to adapt the error from the platform interface
Never adaptErrors({
  required Object error,
  required StackTrace stackTrace,
}) {
  if (error is PaymentCancelledByUserExceptionInterface) {
    throw PaymentCancelledByUserException();
  }
  Error.throwWithStackTrace(error, stackTrace);
}
