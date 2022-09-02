(cd flutter_payzen_platform_interface && \
flutter pub run pigeon \
  --input pigeons/info.dart \
  --dart_out lib/info.g.dart \
  --java_out ../flutter_payzen_android/android/src/main/java/tech/bam/flutter_payzen/android/Info.java \
  --java_package "tech.bam.flutter_payzen.android" \
  --objc_header_out ../flutter_payzen_ios/ios/Classes/info.h \
  --objc_source_out ../flutter_payzen_ios/ios/Classes/info.m \
)