//
//  BUFullscreenVideoCustomEvent.h
//  BUAdSDKDemo
//
//  Created by bytedance_yuanhuan on 2018/11/1.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PangleFullscreenVideoCustomEvent : MPInterstitialCustomEvent

@end

NS_ASSUME_NONNULL_END
