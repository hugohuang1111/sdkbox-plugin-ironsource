#pragma once

#import <UIKit/UIKit.h>
#import "Bridge/BBPluginBase.h"

@interface BBPluginIronSource : BBPluginBase

- (void) launch: (BBMsg* _Nonnull) msg;
- (void) validateIntegration: (BBMsg* _Nonnull) msg;
- (void) setConsent: (BBMsg* _Nonnull) msg;
- (void) setMetaData: (BBMsg* _Nonnull) msg;
- (void) setUserId: (BBMsg* _Nonnull) msg;
- (void) setSegment: (BBMsg* _Nonnull) msg;
- (void) setRewardedVideoServerParameters: (BBMsg* _Nonnull) msg;
- (void) clearRewardedVideoServerParameters: (BBMsg* _Nonnull) msg;
- (void) setOfferwallCustomParams: (BBMsg* _Nonnull) msg;
- (void) shouldTrackNetworkState: (BBMsg* _Nonnull) msg;
- (void) isRewardedVideoAvailable: (BBMsg* _Nonnull) msg;
- (void) showRewardedVideo: (BBMsg* _Nonnull) msg;
- (void) isRewardedVideoPlacementCapped: (BBMsg* _Nonnull) msg;
- (void) setDynamicUserId: (BBMsg* _Nonnull) msg;
- (void) loadInterstitial: (BBMsg* _Nonnull) msg;
- (void) isInterstitialReady: (BBMsg* _Nonnull) msg;
- (void) isInterstitialPlacementCapped: (BBMsg* _Nonnull) msg;
- (void) showInterstitial: (BBMsg* _Nonnull) msg;
- (void) loadBanner: (BBMsg* _Nonnull) msg;
- (void) destroyBanner: (BBMsg* _Nonnull) msg;
- (void) showOfferwall: (BBMsg* _Nonnull) msg;
- (void) getOfferwallCredits: (BBMsg* _Nonnull) msg;
- (void) setClientSideCallbacks: (BBMsg* _Nonnull) msg;

@end

