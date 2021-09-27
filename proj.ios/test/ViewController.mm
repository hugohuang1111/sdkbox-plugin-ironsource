
#import <vector>
#import "ViewController.h"
#import "../../package/cpp/PluginIronSource.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *logArea;

@property NSMutableArray* logLines;

- (void) log:(NSString*)s;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.logLines = [[NSMutableArray alloc] initWithCapacity:10];
    sdkbox::bb::plugin::IronSource::setListener([self](const std::string& evt, const std::string& json) {
        NSString* nss = [NSString stringWithUTF8String: evt.c_str()];
        NSString* nsJson = [NSString stringWithUTF8String: json.c_str()];
        NSLog(@"IS evt:%@ json:%@", nss, nsJson);
        [self log:nss];
    });
}

- (void) log:(NSString*)s {
    [self.logLines addObject:s];
    while (self.logLines.count > 5) {
        [self.logLines removeObjectAtIndex:0];
    }

    self.logArea.text = [self.logLines componentsJoinedByString:@"\n"];
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

    // "11324e71d"
    sdkbox::bb::plugin::IronSource::launch("11324e71d");
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
            NSLog(@"IS Rewarded capped: %@", 0 == b ? @"no" : @"yes");
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
