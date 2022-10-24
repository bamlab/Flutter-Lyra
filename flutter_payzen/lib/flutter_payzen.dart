// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs

import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';

FlutterPayzenPlatform get _platform => FlutterPayzenPlatform.instance;

class SuperInfos {
  const SuperInfos({required this.info1, required this.info2});

  final String info1;
  final String info2;
}

class InvalidDataException implements Exception {
  const InvalidDataException([this.message = '']);

  final String message;
}

/// Returns the name of the current platform.
Future<SuperInfos> search() async {
  final infos = await _platform.search();

  if (infos == null) {
    throw const InvalidDataException('no infos retrieved');
  }

  final info1 = infos.info1;
  final info2 = infos.info2;

  if (info1 == null && info2 == null) {
    throw const InvalidDataException('missing info1 and info2');
  }
  if (info1 == null) {
    throw const InvalidDataException('missing info1');
  }
  if (info2 == null) {
    throw const InvalidDataException('missing info2');
  }

  return SuperInfos(info1: info1, info2: info2);
}
