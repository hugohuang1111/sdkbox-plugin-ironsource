#import <UserNotifications/UserNotifications.h>
#import <IronSource/IronSource.h>
#import "Bridge/BBUtilsIOS.h"
#import "BBPluginIronSource.h"
#import "BBPluginIronSourceDelegate.h"
#import "BBUNUserNotificationCenterDelegate.h"

@implementation BBPluginIronSource
{
    BBPluginIronSourceDelegate* delegate;
    BBUNUserNotificationCenterDelegate* unDelegate;
    NSString* bannerAlignment;
}

- (instancetype)init {
    self = [super init];
    
    delegate = [[BBPluginIronSourceDelegate alloc] init];
    delegate.plugin = self;

    return self;
}

- (void) dealloc {
    delegate = nil;
    [self destroyBanner:nil];
}

- (void) launch: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];
    [ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = @(YES);

    [IronSource setRewardedVideoDelegate: delegate];
    [IronSource setInterstitialDelegate: delegate];
    [IronSource setOfferwallDelegate: delegate];
    [IronSource setSegmentDelegate: delegate];
    [IronSource setBannerDelegate: delegate];
    [IronSource initWithAppKey: nss];
    // [IronSource initWithAppKey: nss adUnits:@[IS_REWARDED_VIDEO, IS_INTERSTITIAL, IS_OFFERWALL, IS_BANNER]];
    // [ISIntegrationHelper validateIntegration];

//    if (@available(iOS 10, *)) {
//        unDelegate = [[BBUNUserNotificationCenterDelegate alloc] init];
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = unDelegate;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        }];
//    } else {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    }
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void) validateIntegration: (BBMsg* _Nonnull) msg {
    [ISIntegrationHelper validateIntegration];
}

- (void) setConsent: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    BOOL b = [msg getValueBOOL:0];
    [IronSource setConsent: b];
}

- (void) setMetaData: (BBMsg* _Nonnull) msg {
    if (2 != [msg getValuesLength]) {
        return;
    }
    NSString* nss1 = [msg getValue:0];
    NSString* nss2 = [msg getValue:1];
    [IronSource setMetaDataWithKey: nss1 value: nss2];
}

- (void) setUserId: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];
    [IronSource setUserId:nss];
}

- (void) setSegment: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* jsonStr = (NSString*)[msg getValue:0];
    NSDictionary* dic = [BBUtilsIOS json2dic:jsonStr];
    if (nil == dic) {
        NSLog(@"ERROR, IronSource setAdditionalData data is nil");
        return;
    }

    ISSegment *segment = [[ISSegment alloc]init];

    NSString* key = nil;
    
    key = @"name";
    NSString* nss = [dic valueForKey: @"name"];
    if (nil != nss) {
        [segment setSegmentName: nss];
    }
    // Set user age
    nss = [dic valueForKey: @"age"];
    if (nil != nss) {
        [segment setAge: [nss intValue]];
    }
    // Set user gender
    nss = [dic valueForKey: @"gender"];
    if (nil != nss) {
        ISGender gender = (ISGender)[nss integerValue];
        [segment setGender: gender];
    }
    // Set user level
    nss = [dic valueForKey: @"level"];
    if (nil != nss) {
        [segment setLevel: [nss intValue]];
    }
    // Set user's paying status
    nss = [dic valueForKey: @"isPaying"];
    if (nil != nss) {
        [segment setPaying: [nss boolValue]];
    }
    // Set user's total in-app purchase history
    nss = [dic valueForKey: @"IAPTotal"];
    if (nil != nss) {
        [segment setIapTotal: [nss integerValue]];
    }
    // Set user creation date
    nss = [dic valueForKey: @"userCreationDate"];
    if (nil != nss) {
        NSDate* d = [NSDate dateWithTimeIntervalSince1970: [nss integerValue]/1000];
        [segment setUserCreationDate: d];
    }
    
    dic = dic[@"custom"];
    if (nil != dic) {
        for (NSString *key in dic) {
            NSString *val = [dic objectForKey:key];
            [segment setCustomValue: key forKey: val];
        }
    }

    [IronSource setSegment: segment];
}

- (void) setRewardedVideoServerParameters: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* jsonStr = (NSString*)[msg getValue:0];
    NSDictionary* dic = [BBUtilsIOS json2dic:jsonStr];
    if (nil == dic) {
        NSLog(@"ERROR, IronSource setRewardedVideoServerParameters data is nil");
        return;
    }
    [IronSource setRewardedVideoServerParameters: dic];
}

- (void) clearRewardedVideoServerParameters: (BBMsg* _Nonnull) msg {
    [IronSource clearRewardedVideoServerParameters];
}

- (void) setOfferwallCustomParams: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* jsonStr = (NSString*)[msg getValue:0];
    NSDictionary* dic = [BBUtilsIOS json2dic:jsonStr];
    if (nil == dic) {
        NSLog(@"ERROR, IronSource setOfferwallCustomParams data is nil");
        return;
    }
    [ISConfigurations getConfigurations].offerwallCustomParameters = dic;
}

- (void) shouldTrackNetworkState: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    BOOL b = [msg getValueBOOL:0];
    [IronSource shouldTrackReachability: b];
}

- (void) isRewardedVideoAvailable: (BBMsg* _Nonnull) msg {
    BOOL b = [IronSource hasRewardedVideo];
    NSNumber* num = [NSNumber numberWithInt:0];
    if (b) {
        num = [NSNumber numberWithInt:1];
    }
    [msg cleanValues];
    [msg pushValueNumber: num];
    [self send: msg];
}

- (void) showRewardedVideo: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];

    [IronSource showRewardedVideoWithViewController: [BBUtilsIOS getRootViewController]
                                          placement: nss];
}

- (void) isRewardedVideoPlacementCapped: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];
    BOOL b = [IronSource isRewardedVideoCappedForPlacement: nss];
    [msg cleanValues];
    [msg pushValueNumber: b ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0]];
    [self send: msg];
}

- (void) setDynamicUserId: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];
    [IronSource setDynamicUserId: nss];
}

- (void) loadInterstitial: (BBMsg* _Nonnull) msg {
    [IronSource loadInterstitial];
}

- (void) isInterstitialReady: (BBMsg* _Nonnull) msg {
    BOOL b = [IronSource hasInterstitial];
    [msg cleanValues];
    [msg pushValueNumber: b ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0]];
    [self send: msg];
}

- (void) isInterstitialPlacementCapped: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    NSString* nss = [msg getValue:0];
    BOOL b = [IronSource isInterstitialCappedForPlacement:nss];
    [msg cleanValues];
    [msg pushValueNumber: b ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0]];
    [self send: msg];
}

- (void) showInterstitial: (BBMsg* _Nonnull) msg {
    [IronSource showInterstitialWithViewController: [BBUtilsIOS getRootViewController]];
}

- (void) loadBanner: (BBMsg* _Nonnull) msg {
    if (2 != [msg getValuesLength]) {
        return;
    }
    NSString* alignment = [msg getValue:0];
    // NSString* placement = [msg getValue:1];
    bannerAlignment = alignment;
    [IronSource loadBannerWithViewController: [BBUtilsIOS getRootViewController] size:ISBannerSize_SMART];
}

- (void) destroyBanner: (BBMsg* _Nonnull) msg {
    if (nil == self.bannerView) {
        return;
    }
    [self.bannerView removeFromSuperview];
    [IronSource destroyBanner: self.bannerView];
    self.bannerView = nil;
}

- (void) showBanner {
    if (nil == self.bannerView) {
        return;
    }

    NSString* alignment = bannerAlignment;
    UIViewController* vc = [BBUtilsIOS getRootViewController];
    UIView* bv = self.bannerView;
    [vc.view addSubview: bv];
    if (@available(ios 11.0, *)) {
        do {
            UILayoutGuide *guide = vc.view.safeAreaLayoutGuide;
            if (!guide) break;

            bv.translatesAutoresizingMaskIntoConstraints = NO;
            NSMutableArray *constraints = [NSMutableArray array];

            if (NSOrderedSame == [@"top" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor] ];
                [constraints addObject:[bv.topAnchor constraintEqualToAnchor:guide.topAnchor] ];
            } else if (NSOrderedSame == [@"bottom" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor] ];
                [constraints addObject:[bv.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor] ];
            } else if (NSOrderedSame == [@"left" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor] ];
                [constraints addObject:[bv.leftAnchor constraintEqualToAnchor:guide.leftAnchor] ];
            } else if (NSOrderedSame == [@"right" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor] ];
                [constraints addObject:[bv.rightAnchor constraintEqualToAnchor:guide.rightAnchor] ];
            } else if (NSOrderedSame == [@"center" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor] ];
                [constraints addObject:[bv.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor] ];
            } else if (NSOrderedSame == [@"top_left" caseInsensitiveCompare: alignment]
                       || NSOrderedSame == [@"left_top" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.leftAnchor constraintEqualToAnchor:guide.leftAnchor] ];
                [constraints addObject:[bv.topAnchor constraintEqualToAnchor:guide.topAnchor] ];
            } else if (NSOrderedSame == [@"top_right" caseInsensitiveCompare: alignment]
                       || NSOrderedSame == [@"right_top" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.rightAnchor constraintEqualToAnchor:guide.rightAnchor] ];
                [constraints addObject:[bv.topAnchor constraintEqualToAnchor:guide.topAnchor] ];
            } else if (NSOrderedSame == [@"bottom_left" caseInsensitiveCompare: alignment]
                       || NSOrderedSame == [@"left_bottom" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.leftAnchor constraintEqualToAnchor:guide.leftAnchor] ];
                [constraints addObject:[bv.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor] ];
            } else if (NSOrderedSame == [@"bottom_right" caseInsensitiveCompare: alignment]
                       || NSOrderedSame == [@"right_bottom" caseInsensitiveCompare: alignment]) {
                [constraints addObject:[bv.rightAnchor constraintEqualToAnchor:guide.rightAnchor] ];
                [constraints addObject:[bv.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor] ];
            } else {
                [constraints addObject:[bv.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor] ];
                [constraints addObject:[bv.topAnchor constraintEqualToAnchor:guide.topAnchor] ];
            }

            [NSLayoutConstraint activateConstraints:constraints];
        } while (0);
    }
}

- (void) showOfferwall: (BBMsg* _Nonnull) msg {
    [IronSource showOfferwallWithViewController: [BBUtilsIOS getRootViewController]];
}

- (void) getOfferwallCredits: (BBMsg* _Nonnull) msg {
    [IronSource offerwallCredits];
}

- (void) setClientSideCallbacks: (BBMsg* _Nonnull) msg {
    if (1 != [msg getValuesLength]) {
        return;
    }
    BOOL b = [msg getValueBOOL:0];
    NSNumber* num = [NSNumber numberWithInt:0];
    if (b) {
        num = [NSNumber numberWithInt:1];
    }
    [ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = num;
}

@end

