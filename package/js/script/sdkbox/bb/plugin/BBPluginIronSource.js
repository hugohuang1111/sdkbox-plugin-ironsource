
var sdkbox = sdkbox || {};
sdkbox.bb = sdkbox.bb || {};
sdkbox.bb.plugin = sdkbox.bb.plugin || {};
if (!sdkbox.bb.plugin.IronSource) {

let Msg = sdkbox.bb.Msg;
let BBPluginIronSource = {}

BBPluginIronSource.init = function() {
    sdkbox.bb.Bridge.init();

    if (BBPluginIronSource._isAndroid()) {
        sdkbox.bb.Bridge.addPlugin("IronSource", "com.sdkbox.bb.bridge.plugin.ironsource.PluginIronSource");
    } else if (BBPluginIronSource._isIOS()) {
        sdkbox.bb.Bridge.addPlugin("IronSource", "BBPluginIronSource");
    }
}

BBPluginIronSource.setListener = function(lis) {
    if(!lis) {
        return;
    }
    sdkbox.bb.Bridge.onRecv(function(msg) {
        if ("IronSource" != msg.plugin) {
            return;
        }
        lis(msg.values[0], msg.values[1]);
    })
}

BBPluginIronSource.start = function() {
    const m = new Msg("IronSource", "init");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.launch = function(appKey) {
    const m = new Msg("IronSource", "launch");
    m.pushValue(appKey);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.validateIntegration = function() {
    const m = new Msg("IronSource", "validateIntegration");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setConsent = function(b) {
    const m = new Msg("IronSource", "setConsent");
    m.pushValue(b);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setMetaData = function(key, val) {
    const m = new Msg("IronSource", "setMetaData");
    m.pushValue(key);
    m.pushValue(val);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setUserId = function(uid) {
    const m = new Msg("IronSource", "setUserId");
    m.pushValue(uid);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setSegment = function(seg) {
    const m = new Msg("IronSource", "setSegment");
    m.pushValue(seg);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setRewardedVideoServerParameters = function(params) {
    const m = new Msg("IronSource", "setRewardedVideoServerParameters");
    m.pushValue(JSON.stringify(params));

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.clearRewardedVideoServerParameters = function() {
    const m = new Msg("IronSource", "clearRewardedVideoServerParameters");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setOfferwallCustomParams = function(params) {
    const m = new Msg("IronSource", "setOfferwallCustomParams");
    m.pushValue(JSON.stringify(params));

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.shouldTrackNetworkState = function(b) {
    const m = new Msg("IronSource", "shouldTrackNetworkState");
    m.pushValue(b);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.isRewardedVideoAvailable = function(cb, placement) {
    const m = new Msg("IronSource", "isRewardedVideoAvailable");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg) {
        cb && cb(msg.values[0]);
    });
}

BBPluginIronSource.showRewardedVideo = function(placement) {
    const m = new Msg("IronSource", "showRewardedVideo");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.isRewardedVideoPlacementCapped = function(cb, placement) {
    const m = new Msg("IronSource", "isRewardedVideoPlacementCapped");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg) {
        cb && cb(msg.values[0]);
    });
}

BBPluginIronSource.setDynamicUserId = function(uid) {
    const m = new Msg("IronSource", "setDynamicUserId");
    m.pushValue(uid);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.loadInterstitial = function() {
    const m = new Msg("IronSource", "loadInterstitial");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.isInterstitialReady = function(cb, placement) {
    const m = new Msg("IronSource", "isInterstitialReady");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg) {
        cb && cb(msg.values[0]);
    });
}

BBPluginIronSource.isInterstitialPlacementCapped = function(cb, placement) {
    const m = new Msg("IronSource", "isInterstitialPlacementCapped");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg) {
        cb && cb(msg.values[0]);
    });
}

BBPluginIronSource.showInterstitial = function(placement) {
    const m = new Msg("IronSource", "showInterstitial");
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.loadBanner = function(alignment, placement) {
    const m = new Msg("IronSource", "loadBanner");
    m.pushValue(alignment);
    m.pushValue(placement);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.destroyBanner = function() {
    const m = new Msg("IronSource", "destroyBanner");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.showOfferwall = function() {
    const m = new Msg("IronSource", "showOfferwall");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.getOfferwallCredits = function() {
    const m = new Msg("IronSource", "getOfferwallCredits");

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource.setClientSideCallbacks = function(b) {
    const m = new Msg("IronSource", "setClientSideCallbacks");
    m.pushValue(b);

    sdkbox.bb.Bridge.send(m);
}

BBPluginIronSource._isAndroid = function() {
    if (cc) {
        if (cc.sys.platform == cc.sys.ANDROID) {
            return true;
        }
    } else {
        if (sys.os === sys.OS_ANDROID) {
            return true;
        }
    }
    return false;
}

BBPluginIronSource._isIOS = function() {
    if (cc) {
        if (cc.sys.platform == cc.sys.IPHONE || cc.sys.platform == cc.sys.IPAD) {
            return true;
        }
    } else {
        if (sys.os === sys.OS_IOS) {
            return true;
        }
    }
    return false;
}


sdkbox.bb.plugin.IronSource = BBPluginIronSource;

}
