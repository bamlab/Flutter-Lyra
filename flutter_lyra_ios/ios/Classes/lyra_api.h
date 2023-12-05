// Autogenerated from Pigeon (v7.0.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class ErrorCodesInterface;
@class LyraInitializeOptionsInterface;
@class LyraKeyInterface;
@class ProcessRequestInterface;

@interface ErrorCodesInterface : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPaymentCancelledByUser:(NSString *)paymentCancelledByUser;
@property(nonatomic, copy) NSString * paymentCancelledByUser;
@end

@interface LyraInitializeOptionsInterface : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithApiServerName:(NSString *)apiServerName
    nfcEnabled:(nullable NSNumber *)nfcEnabled
    cardScanningEnabled:(nullable NSNumber *)cardScanningEnabled
    applePayMerchantId:(nullable NSString *)applePayMerchantId
    applePayMerchantName:(nullable NSString *)applePayMerchantName;
@property(nonatomic, copy) NSString * apiServerName;
@property(nonatomic, strong, nullable) NSNumber * nfcEnabled;
@property(nonatomic, strong, nullable) NSNumber * cardScanningEnabled;
@property(nonatomic, copy, nullable) NSString * applePayMerchantId;
@property(nonatomic, copy, nullable) NSString * applePayMerchantName;
@end

@interface LyraKeyInterface : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPublicKey:(NSString *)publicKey
    options:(LyraInitializeOptionsInterface *)options;
@property(nonatomic, copy) NSString * publicKey;
@property(nonatomic, strong) LyraInitializeOptionsInterface * options;
@end

@interface ProcessRequestInterface : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithFormToken:(NSString *)formToken
    errorCodes:(ErrorCodesInterface *)errorCodes
    timeoutInSeconds:(nullable NSNumber *)timeoutInSeconds;
@property(nonatomic, copy) NSString * formToken;
@property(nonatomic, strong) ErrorCodesInterface * errorCodes;
@property(nonatomic, strong, nullable) NSNumber * timeoutInSeconds;
@end

/// The codec used by LyraHostApi.
NSObject<FlutterMessageCodec> *LyraHostApiGetCodec(void);

@protocol LyraHostApi
- (void)initializeLyraKey:(LyraKeyInterface *)lyraKey completion:(void (^)(LyraKeyInterface *_Nullable, FlutterError *_Nullable))completion;
- (void)getFormTokenVersionWithCompletion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)processRequest:(ProcessRequestInterface *)request completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
@end

extern void LyraHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<LyraHostApi> *_Nullable api);

NS_ASSUME_NONNULL_END
