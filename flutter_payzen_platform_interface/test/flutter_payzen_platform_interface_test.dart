// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_payzen_platform_interface/info.dart';
import 'package:flutter_test/flutter_test.dart';

class FlutterPayzenMock extends FlutterPayzenPlatform {
  static final mockSearchInfos = Infos(info1: 'info1', info2: 'info2');

  @override
  Future<Infos> search() async => mockSearchInfos;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('FlutterPayzenPlatformInterface', () {
    late FlutterPayzenPlatform flutterPayzenPlatform;

    setUp(() {
      flutterPayzenPlatform = FlutterPayzenMock();
      FlutterPayzenPlatform.instance = flutterPayzenPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await FlutterPayzenPlatform.instance.search(),
          equals(FlutterPayzenMock.mockSearchInfos),
        );
      });
    });
  });
}
