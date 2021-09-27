#pragma once

#import <Foundation/Foundation.h>
#import <IronSource/IronSource.h>
#import "BBPluginIronSource.h"

@interface BBPluginIronSourceDelegate : NSObject <ISRewardedVideoDelegate, ISInterstitialDelegate, ISOfferwallDelegate, ISBannerDelegate, ISSegmentDelegate>

@property(nonatomic, weak) BBPluginIronSource* plugin;



// ISRewardedVideoDelegate

/**
 Called after a rewarded video has changed its availability.
 
 @param available The new rewarded video availability. YES if available and ready to be shown, NO otherwise.
 */
- (void)rewardedVideoHasChangedAvailability:(BOOL)available;

/**
  Called after a rewarded video has been viewed completely and the user is eligible for reward.

 @param placementInfo An object that contains the placement's reward name and amount.
 */
- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo;

/**
 Called after a rewarded video has attempted to show but failed.
 
 @param error The reason for the error
 */
- (void)rewardedVideoDidFailToShowWithError:(NSError *)error;

/**
 Called after a rewarded video has been opened.
 */
- (void)rewardedVideoDidOpen;

/**
 Called after a rewarded video has been dismissed.
 */
- (void)rewardedVideoDidClose;

/**
 * Note: the events below are not available for all supported rewarded video ad networks.
 * Check which events are available per ad network you choose to include in your build.
 * We recommend only using events which register to ALL ad networks you include in your build.
 */

/**
 Called after a rewarded video has started playing.
 */
- (void)rewardedVideoDidStart;

/**
 Called after a rewarded video has finished playing.
 */
- (void)rewardedVideoDidEnd;

/**
 Called after a video has been clicked.
 */
- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo;




#pragma mark Interstitial Delegate
// ISInterstitialDelegate

/**
 Called after an interstitial has been loaded
 */
- (void)interstitialDidLoad;

/**
 Called after an interstitial has attempted to load but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToLoadWithError:(NSError *)error;

/**
 Called after an interstitial has been opened.
 */
- (void)interstitialDidOpen;

/**
  Called after an interstitial has been dismissed.
 */
- (void)interstitialDidClose;

/**
 Called after an interstitial has been displayed on the screen.
 */
- (void)interstitialDidShow;

/**
 Called after an interstitial has attempted to show but failed.

 @param error The reason for the error
 */
- (void)interstitialDidFailToShowWithError:(NSError *)error;

/**
 Called after an interstitial has been clicked.
 */
- (void)didClickInterstitial;



// ISOfferwallDelegate

/**
 Called after the offerwall has changed its availability.
 
 @param available The new offerwall availability. YES if available and ready to be shown, NO otherwise.
 */
- (void)offerwallHasChangedAvailability:(BOOL)available;

/**
 Called after the offerwall has been displayed on the screen.
 */
- (void)offerwallDidShow;

/**
 Called after the offerwall has attempted to show but failed.
 
 @param error The reason for the error.
 */
- (void)offerwallDidFailToShowWithError:(NSError *)error;

/**
 Called after the offerwall has been dismissed.
 */
- (void)offerwallDidClose;

/**
 @abstract Called each time the user completes an offer.
 @discussion creditInfo is a dictionary with the following key-value pairs:
 
 "credits" - (int) The number of credits the user has Earned since the last didReceiveOfferwallCredits event that returned YES. Note that the credits may represent multiple completions (see return parameter).
 
 "totalCredits" - (int) The total number of credits ever earned by the user.
 
 "totalCreditsFlag" - (BOOL) In some cases, we won’t be able to provide the exact amount of credits since the last event (specifically if the user clears the app’s data). In this case the ‘credits’ will be equal to the "totalCredits", and this flag will be YES.
 
 @param creditInfo Offerwall credit info.
 
 @return The publisher should return a BOOL stating if he handled this call (notified the user for example). if the return value is NO, the 'credits' value will be added to the next call.
 */
- (BOOL)didReceiveOfferwallCredits:(NSDictionary *)creditInfo;

/**
 Called after the 'offerwallCredits' method has attempted to retrieve user's credits info but failed.
 
 @param error The reason for the error.
 */
- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error;




// ISBannerDelegate

/**
 Called after a banner ad has been successfully loaded
 */
- (void)bannerDidLoad:(ISBannerView *)bannerView;

/**
 Called after a banner has attempted to load an ad but failed.
 
 @param error The reason for the error
 */
- (void)bannerDidFailToLoadWithError:(NSError *)error;

/**
 Called after a banner has been clicked.
 */
- (void)didClickBanner;

/**
 Called when a banner is about to present a full screen content.
 */
- (void)bannerWillPresentScreen;

/**
 Called after a full screen content has been dismissed.
 */
- (void)bannerDidDismissScreen;

/**
 Called when a user would be taken out of the application context.
 */
- (void)bannerWillLeaveApplication;



// ISSegmentDelegate

/**
 Called after a segment recived successfully
 */
- (void)didReceiveSegement:(NSString *)segment;


@end

