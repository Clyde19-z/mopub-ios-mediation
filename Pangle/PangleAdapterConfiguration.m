#import "PangleAdapterConfiguration.h"
#import <BUAdSDK/BUAdSDKManager.h>

@implementation PangleAdapterConfiguration

NSString * const kPangleAppIdKey = @"app_id";
NSString * const kPanglePlacementIdKey = @"ad_placement_id";

static NSString * const kAdapterVersion = @"3.0.0.7.1";
static NSString * const kAdapterErrorDomain = @"com.mopub.mopub-ios-sdk.mopub-pangle-adapters";

typedef NS_ENUM(NSInteger, PangleAdapterErrorCode) {
    PangleAdapterErrorCodeMissingIdKey,
};

#pragma mark - MPAdapterConfiguration

- (NSString *)adapterVersion {
    return kAdapterVersion;
}

- (NSString *)biddingToken {
    return [BUAdSDKManager mopubBiddingToken];
}

- (NSString *)moPubNetworkName {
    return @"pangle";
}

- (NSString *)networkSdkVersion {
    return [BUAdSDKManager SDKVersion];
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration complete:(void(^)(NSError *))complete {
    NSString *appId = configuration[kPangleAppIdKey];
    if (!BUCheckValidString(appId)) {
        NSError *error = [NSError errorWithDomain:kAdapterErrorDomain
                                             code:PangleAdapterErrorCodeMissingIdKey
                                         userInfo:@{NSLocalizedDescriptionKey:
                                                        @"Invalid or missing Pangle appId, please set networkConfig refer to method '-configCustomEvent' in 'AppDelegate' class"}];
        if (complete != nil) {
            complete(error);
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [BUAdSDKManager setAppID:appId];
            MPBLogLevel logLevel = [MPLogging consoleLogLevel];
            BOOL verboseLoggingEnabled = (logLevel == MPBLogLevelDebug);
            
            [BUAdSDKManager setLoglevel:(verboseLoggingEnabled == true ? BUAdSDKLogLevelDebug : BUAdSDKLogLevelNone)];
            if ([[MoPub sharedInstance] isGDPRApplicable] != MPBoolUnknown) {
                BOOL canCollectPersonalInfo =  [[MoPub sharedInstance] canCollectPersonalInfo];
                /// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
                /// @params GDPR 0 close privacy protection, 1 open privacy protection
                [BUAdSDKManager setGDPR:canCollectPersonalInfo ? 0 : 1];
            }
            if (complete != nil) {
                complete(nil);
            }
        });
    }
}

#pragma mark - Update the network initialization parameters cache
+ (void)updateInitializationParameters:(NSDictionary *)parameters {
    NSString * appId = parameters[kPangleAppIdKey];
    
    if (BUCheckValidString(appId)) {
        NSDictionary * configuration = @{kPangleAppIdKey: appId};
        [PangleAdapterConfiguration setCachedInitializationParameters:configuration];
    }
}
@end
