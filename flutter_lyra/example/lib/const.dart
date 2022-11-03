abstract class DataSet {
  const DataSet();

  /// Your data set name
  String get name;

  /// Your lyra public key
  String get initialPublicKey;

  /// Your lyra api server name
  String get initialApiServerName;

  /// Your merchant url
  String get initialMerchantUrl;

  /// Your merchant username
  String get initialMerchantUsername;

  /// Your merchant password
  String get initialMerchantPassword;

  /// Create payment request payload route path
  String get initialCreatePaymentRoutePath;

  /// Create payment request payload currency
  Map<String, Object?> initialCreatePaymentPayload(int formTokenVersion);
}

class _FirstDataSet extends DataSet {
  const _FirstDataSet();

  /// Your data set name
  @override
  String get name => 'My First Instance Data Set';

  /// Your lyra public key
  @override
  String get initialPublicKey => '';

  /// Your lyra api server name
  @override
  String get initialApiServerName => '';

  /// Your merchant url
  @override
  String get initialMerchantUrl => 'https://api.payzen.eu/api-payment/V4';

  /// Your merchant username
  @override
  String get initialMerchantUsername => '';

  /// Your merchant password
  @override
  String get initialMerchantPassword => '';

  /// Create payment request payload route path
  @override
  String get initialCreatePaymentRoutePath => '/Charge/CreatePayment';

  /// Create payment request payload currency
  @override
  Map<String, Object?> initialCreatePaymentPayload(int formTokenVersion) =>
      <String, Object?>{
        'currency': 'EUR',
        'amount': 100,
        'orderId': 'orderId',
        'customer': {
          'email': 'customer@email.com',
          'reference': 'customerReference'
        },
        'formTokenVersion': formTokenVersion,
        'mode': 'TEST' // value 'TEST' or 'PRODUCTION'
      };
}

class DataSets {
  // ignore: library_private_types_in_public_api
  static DataSet get firstDataSet => const _FirstDataSet();
}
