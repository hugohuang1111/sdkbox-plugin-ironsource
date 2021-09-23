
#import <vector>
#import "ViewController.h"
#import "../../package/cpp/PluginIronSource.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    sdkbox::bb::plugin::IronSource::setListener([](const std::string& evt, const std::string& json) {
        NSString* nss = [NSString stringWithUTF8String: evt.c_str()];
        NSString* nsJson = [NSString stringWithUTF8String: json.c_str()];
        NSLog(@"IS evt:%@ json:%@", nss, nsJson);
    });
}

- (IBAction)onBtnInit:(id)sender {
    NSLog(@"IS btn init");
}

- (IBAction)onBtnStart:(id)sender {
    NSLog(@"IS btn start");
    sdkbox::bb::plugin::IronSource::setMetaData("k1", "v1");
    sdkbox::bb::plugin::IronSource::setUserId("uid10001");
    sdkbox::bb::plugin::IronSource::setConsent(true);
    sdkbox::bb::plugin::IronSource::setSegment("");
    sdkbox::bb::plugin::IronSource::setRewardedVideoServerParameters({});
    sdkbox::bb::plugin::IronSource::clearRewardedVideoServerParameters();
    sdkbox::bb::plugin::IronSource::setOfferwallCustomParams({});
    sdkbox::bb::plugin::IronSource::shouldTrackNetworkState(true);

    sdkbox::bb::plugin::IronSource::setDynamicUserId("dynuid10001");

    sdkbox::bb::plugin::IronSource::getOfferwallCredits();
    sdkbox::bb::plugin::IronSource::setClientSideCallbacks(true);

    // "10b5adc55"
    sdkbox::bb::plugin::IronSource::launch("10b5adc55");
}

- (IBAction)onBtnIntegrationCheck:(id)sender {
    NSLog(@"IS btn integration check");
    sdkbox::bb::plugin::IronSource::validateIntegration();
}

- (IBAction)onBtnLoadBanner:(id)sender {
    NSLog(@"IS btn load banner");
    sdkbox::bb::plugin::IronSource::loadBanner("");
}

- (IBAction)onBtnDestoryBanner:(id)sender {
    NSLog(@"IS btn destory banner");
    sdkbox::bb::plugin::IronSource::destroyBanner();
}

- (IBAction)onBtnLoadInterstitial:(id)sender {
    NSLog(@"IS btn load interstitial");
    sdkbox::bb::plugin::IronSource::loadInterstitial();
}

- (IBAction)onBtnShowInterstitial:(id)sender {
    NSLog(@"IS btn show interstitial");
    sdkbox::bb::plugin::IronSource::isInterstitialReady([](bool b) {
        if (!b) {
            NSLog(@"IS Interstitial is not available");
            return;
        }
        sdkbox::bb::plugin::IronSource::showInterstitial("");
    }, "");
}

- (IBAction)onBtnRewardCapped:(id)sender {
    NSLog(@"IS btn reward capped");
    sdkbox::bb::plugin::IronSource::isRewardedVideoPlacementCapped([](bool b) {
        if (!b) {
            NSLog(@"IS Rewarded capped: %d", b);
            return;
        }
    }, "");
}

- (IBAction)onBtnShowReward:(id)sender {
    NSLog(@"IS btn show reward");
    sdkbox::bb::plugin::IronSource::isRewardedVideoAvailable([](bool b) {
        if (!b) {
            NSLog(@"IS Rewarded Video is not available");
            return;
        }

        sdkbox::bb::plugin::IronSource::showRewardedVideo("");
    }, "");
}




@end
