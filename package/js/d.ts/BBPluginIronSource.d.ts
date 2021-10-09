
declare namespace sdkbox.bb.plugin.IronSource {

    export function init();
    export function setListener(lis: (event: string, data: any) => void);
    export function start();
    export function launch(appKey: string);
    export function validateIntegration();
    export function setConsent(b: boolean);
    export function setMetaData(key: string, val: string);
    export function setUserId(uid: string);
    export function setSegment(seg: string);
    export function setRewardedVideoServerParameters(params: object);
    export function clearRewardedVideoServerParameters();
    export function setOfferwallCustomParams(params: object);
    export function shouldTrackNetworkState(b: boolean);
    export function isRewardedVideoAvailable(cb, placement: string);
    export function showRewardedVideo(placement);
    export function isRewardedVideoPlacementCapped(cb, placement: string);
    export function setDynamicUserId(uid: string);
    export function loadInterstitial();
    export function isInterstitialReady(cb, placement: string);
    export function isInterstitialPlacementCapped(cb, placement: string);
    export function showInterstitial(placement: string);
    export function loadBanner(alignment: string, placement: string);
    export function destroyBanner();
    export function showOfferwall();
    export function getOfferwallCredits();
    export function setClientSideCallbacks(b: boolean);

}

