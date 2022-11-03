import '../flutter_lyra_platform_interface.dart';

/// List of differents error codes that will be thrown from
/// the native part
final errorCodesInterface = ErrorCodesInterface(
  paymentCancelledByUser: 'payment_cancelled_by_user_code',
);

/// {@macro flutter_lyra.errors.payment_cancelled_by_user_code}
class PaymentCancelledByUserExceptionInterface implements Exception {}
