#import "BBPluginIronSourceDelegate.h"
#import "Bridge/BBUtilsIOS.h"

@implementation BBPluginIronSourceDelegate

- (instancetype)init {
    self = [super init];
    return self;
}


// ISRewardedVideoDelegate

/**
 Called after a rewarded video has changed its availability.
 
 @param available The new rewarded video availability. YES if available and ready to be shown, NO otherwise.
 */
- (void)rewardedVideoHasChangedAvailability:(BOOL)available {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAvailabilityChanged"];
    [msg.values addObject: [NSNumber numberWithInteger: available]];
    [self.plugin send:msg];
}

/**
  Called after a rewarded video has been viewed completely and the user is eligible for reward.

 @param placementInfo An object that contains the placement's reward name and amount.
 */
- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo {
//    if (nil == self.plugin) {
//        return;
//    }
//
//    BBMsg* msg = [self.plugin createDefaultMsg];
//    [msg.values addObject: @"onRewardedVideoAvailabilityChanged"];
//    [msg.values addObject: available];
//    [self.plugin send:msg];
}

/**
 Called after a rewarded video has attempted to show but failed.
 
 @param error The reason for the error
 */
- (void)rewardedVideoDidFailToShowWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdShowFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];

    [self.plugin send:msg];
}

/**
 Called after a rewarded video has been opened.
 */
- (void)rewardedVideoDidOpen {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdOpened"];
    [self.plugin send:msg];
}

/**
 Called after a rewarded video has been dismissed.
 */
- (void)rewardedVideoDidClose {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdClosed"];
    [self.plugin send:msg];
}

/**
 * Note: the events below are not available for all supported rewarded video ad networks.
 * Check which events are available per ad network you choose to include in your build.
 * We recommend only using events which register to ALL ad networks you include in your build.
 */

/**
 Called after a rewarded video has started playing.
 */
- (void)rewardedVideoDidStart {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdStarted"];
    [self.plugin send:msg];
}

/**
 Called after a rewarded video has finished playing.
 */
- (void)rewardedVideoDidEnd {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdEnded"];
    [self.plugin send:msg];
}

/**
 Called after a video has been clicked.
 */
- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onRewardedVideoAdClicked"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"name": placementInfo.placementName,
        @"rewardAmount": placementInfo.rewardAmount,
        @"rewardName": placementInfo.rewardName }]];
    [self.plugin send:msg];
}




// ISInterstitialDelegate

/**
 Called after an interstitial has been loaded
 */
- (void)interstitialDidLoad {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdReady"];
    [self.plugin send:msg];
}

/**
 Called after an interstitial has attempted to load but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToLoadWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdLoadFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];
    [self.plugin send:msg];
}

/**
 Called after an interstitial has been opened.
 */
- (void)interstitialDidOpen {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdOpened"];
    [self.plugin send:msg];
}

/**
  Called after an interstitial has been dismissed.
 */
- (void)interstitialDidClose {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdClosed"];
    [self.plugin send:msg];
}

/**
 Called after an interstitial has been displayed on the screen.
 */
- (void)interstitialDidShow {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdShowSucceeded"];
    [self.plugin send:msg];
}

/**
 Called after an interstitial has attempted to show but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToShowWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdShowFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];
    [self.plugin send:msg];
}

/**
 Called after an interstitial has been clicked.
 */
- (void)didClickInterstitial {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onInterstitialAdClicked"];
    [self.plugin send:msg];
}



// ISOfferwallDelegate

/**
 Called after the offerwall has changed its availability.
 
 @param available The new offerwall availability. YES if available and ready to be shown, NO otherwise.
 */
- (void)offerwallHasChangedAvailability:(BOOL)available {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onOfferwallAvailable"];
    [msg.values addObject: [NSNumber numberWithBool:available]];
    [self.plugin send:msg];
}

/**
 Called after the offerwall has been displayed on the screen.
 */
- (void)offerwallDidShow {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onOfferwallOpened"];
    [self.plugin send:msg];
}

/**
 Called after the offerwall has attempted to show but failed.
 
 @param error The reason for the error.
 */
- (void)offerwallDidFailToShowWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onOfferwallShowFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];
    [self.plugin send:msg];
}

/**
 Called after the offerwall has been dismissed.
 */
- (void)offerwallDidClose {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onOfferwallClosed"];
    [self.plugin send:msg];
}

/**
 @abstract Called each time the user completes an offer.
 @discussion creditInfo is a dictionary with the following key-value pairs:
 
 "credits" - (int) The number of credits the user has Earned since the last didReceiveOfferwallCredits event that returned YES. Note that the credits may represent multiple completions (see return parameter).
 
 "totalCredits" - (int) The total number of credits ever earned by the user.
 
 "totalCreditsFlag" - (BOOL) In some cases, we won’t be able to provide the exact amount of credits since the last event (specifically if the user clears the app’s data). In this case the ‘credits’ will be equal to the "totalCredits", and this flag will be YES.
 
 @param creditInfo Offerwall credit info.
 
 @return The publisher should return a BOOL stating if he handled this call (notified the user for example). if the return value is NO, the 'credits' value will be added to the next call.
 */
- (BOOL)didReceiveOfferwallCredits:(NSDictionary *)creditInfo {
    if (nil == self.plugin) {
        return NO;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onOfferwallAdCredited"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"credits": creditInfo[@"credits"],
        @"totalCredits": creditInfo[@"totalCredits"],
        @"totalCreditsFlag": creditInfo[@"totalCreditsFlag"] }]];

    [self.plugin send:msg];
    
    return YES;
}

/**
 Called after the 'offerwallCredits' method has attempted to retrieve user's credits info but failed.
 
 @param error The reason for the error.
 */
- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onGetOfferwallCreditsFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];
    [self.plugin send:msg];
}




// ISBannerDelegate

/**
 Called after a banner ad has been successfully loaded
 */
- (void)bannerDidLoad:(ISBannerView *)bannerView {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdLoaded"];
    [self.plugin send:msg];
}

/**
 Called after a banner has attempted to load an ad but failed.
 
 @param error The reason for the error
 */
- (void)bannerDidFailToLoadWithError:(NSError *)error {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdLoadFailed"];
    [msg.values addObject: [BBUtilsIOS dic2json: @{
        @"errorCode": [NSNumber numberWithInteger: error.code],
        @"errorMsg": error.description }]];
    [self.plugin send:msg];
}

/**
 Called after a banner has been clicked.
 */
- (void)didClickBanner {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdClicked"];
    [self.plugin send:msg];
}

/**
 Called when a banner is about to present a full screen content.
 */
- (void)bannerWillPresentScreen {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdScreenPresented"];
    [self.plugin send:msg];
}

/**
 Called after a full screen content has been dismissed.
 */
- (void)bannerDidDismissScreen {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdScreenDismissed"];
    [self.plugin send:msg];
}

/**
 Called when a user would be taken out of the application context.
 */
- (void)bannerWillLeaveApplication {
    if (nil == self.plugin) {
        return;
    }

    BBMsg* msg = [self.plugin createDefaultMsg];
    [msg.values addObject: @"onBannerAdLeftApplication"];
    [self.plugin send:msg];
}



// ISSegmentDelegate

/**
 Called after a segment recived successfully
 */
- (void)didReceiveSegement:(NSString *)segment {
}


@end
