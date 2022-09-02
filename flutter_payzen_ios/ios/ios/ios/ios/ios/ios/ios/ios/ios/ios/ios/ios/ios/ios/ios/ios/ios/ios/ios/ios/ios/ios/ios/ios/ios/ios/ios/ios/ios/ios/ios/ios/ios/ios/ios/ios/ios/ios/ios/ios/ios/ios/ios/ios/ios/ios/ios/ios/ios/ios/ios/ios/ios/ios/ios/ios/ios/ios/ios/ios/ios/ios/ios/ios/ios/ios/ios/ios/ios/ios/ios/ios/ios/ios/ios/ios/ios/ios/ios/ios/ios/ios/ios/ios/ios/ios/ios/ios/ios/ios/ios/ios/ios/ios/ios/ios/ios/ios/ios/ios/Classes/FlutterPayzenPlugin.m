#import "FlutterPayzenPlugin.h"
#if __has_include(<flutter_payzen_ios/flutter_payzen_ios-Swift.h>)
#import <flutter_payzen_ios/flutter_payzen_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_payzen_ios-Swift.h"
#endif

@implementation FlutterPayzenPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [SwiftFlutterPayzenPlugin registerWithRegistrar:registrar];
}

@end