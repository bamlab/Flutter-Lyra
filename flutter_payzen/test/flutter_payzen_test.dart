// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_payzen/flutter_payzen.dart';
import 'package:flutter_payzen_platform_interface/flutter_payzen_platform_interface.dart';
import 'package:flutter_payzen_platform_interface/info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPayzenPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements FlutterPayzenPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterPayzen', () {
    late FlutterPayzenPlatform flutterPayzenPlatform;

    setUp(() {
      flutterPayzenPlatform = MockFlutterPayzenPlatform();
      FlutterPayzenPlatform.instance = flutterPayzenPlatform;
    });

    group('search', () {
      test('returns correct name when platform implementation exists',
          () async {
        final infos = Infos(info1: 'info1', info2: 'info2');
        when(
          () => flutterPayzenPlatform.search(),
        ).thenAnswer((_) async => infos);

        final actualPlatformName = await search();
        expect(actualPlatformName, equals(infos));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => flutterPayzenPlatform.search(),
        ).thenAnswer((_) async => Infos());

        expect(search, throwsException);
      });
    });
  });
}
