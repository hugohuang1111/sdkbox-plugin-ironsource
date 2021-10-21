local Msg = require("sdkbox.bb.Msg")

local IronSource = {}

local app = cc.Application:getInstance()
local target = app:getTargetPlatform()


function IronSource.init()
    sdkbox.bb.Bridge.init()

    if target == cc.PLATFORM_OS_ANDROID then
        sdkbox.bb.Bridge.addPlugin("IronSource", "com.sdkbox.bb.bridge.plugin.ironsource.PluginIronSource");
    elseif target == cc.PLATFORM_OS_IPHONE or target == cc.PLATFORM_OS_IPAD then
        sdkbox.bb.Bridge.addPlugin("IronSource", "BBPluginIronSource");
    end

end

function IronSource.setListener(lis)
    if not lis then
        return
    end
    sdkbox.bb.Bridge.onRecv(function(msg)
        if "IronSource" ~= msg.plugin then
            return
        end
        lis(msg.values[1], msg.values[2])
    end)
end


function IronSource.start()
    local m = Msg:create("IronSource", "init");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.launch(appKey)
    local m = Msg:create("IronSource", "launch");
    m:pushValue(appKey);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.validateIntegration()
    local m = Msg:create("IronSource", "validateIntegration");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setConsent(b)
    local m = Msg:create("IronSource", "setConsent");
    m:pushValue(b);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setMetaData(key, val)
    local m = Msg:create("IronSource", "setMetaData");
    m:pushValue(key);
    m:pushValue(val);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setUserId(uid)
    local m = Msg:create("IronSource", "setUserId");
    m:pushValue(uid);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setSegment(seg)
    local m = Msg:create("IronSource", "setSegment");
    m:pushValue(seg);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setRewardedVideoServerParameters(json)
    local m = Msg:create("IronSource", "setRewardedVideoServerParameters");
    m:pushValue(json);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.clearRewardedVideoServerParameters()
    local m = Msg:create("IronSource", "clearRewardedVideoServerParameters");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setOfferwallCustomParams(json)
    local m = Msg:create("IronSource", "setOfferwallCustomParams");
    m:pushValue(json);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.shouldTrackNetworkState(b)
    local m = Msg:create("IronSource", "shouldTrackNetworkState");
    m:pushValue(b);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.isRewardedVideoAvailable(cb, placement)
    local m = Msg:create("IronSource", "isRewardedVideoAvailable");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg)
        if (nil ~= cb) then cb(msg.values[1]) end
    end);
end

function IronSource.showRewardedVideo(placement)
    local m = Msg:create("IronSource", "showRewardedVideo");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.isRewardedVideoPlacementCapped(cb, placement)
    local m = Msg:create("IronSource", "isRewardedVideoPlacementCapped");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg)
        if (nil ~= cb) then cb(msg.values[1]) end
    end);
end

function IronSource.setDynamicUserId(uid)
    local m = Msg:create("IronSource", "setDynamicUserId");
    m:pushValue(uid);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.loadInterstitial()
    local m = Msg:create("IronSource", "loadInterstitial");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.isInterstitialReady(cb, placement)
    local m = Msg:create("IronSource", "isInterstitialReady");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg)
        if (nil ~= cb) then cb(msg.values[1]) end
    end);
end

function IronSource.isInterstitialPlacementCapped(cb, placement)
    local m = Msg:create("IronSource", "isInterstitialPlacementCapped");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m, function(msg)
        if (nil ~= cb) then cb(msg.values[1]) end
    end);
end

function IronSource.showInterstitial(placement)
    local m = Msg:create("IronSource", "showInterstitial");
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.loadBanner(alignment, placement)
    local m = Msg:create("IronSource", "loadBanner");
    m:pushValue(alignment);
    m:pushValue(placement);

    sdkbox.bb.Bridge.send(m)
end

function IronSource.destroyBanner()
    local m = Msg:create("IronSource", "destroyBanner");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.showOfferwall()
    local m = Msg:create("IronSource", "showOfferwall");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.getOfferwallCredits()
    local m = Msg:create("IronSource", "getOfferwallCredits");

    sdkbox.bb.Bridge.send(m)
end

function IronSource.setClientSideCallbacks(b)
    local m = Msg:create("IronSource", "setClientSideCallbacks");
    m:pushValue(b);

    sdkbox.bb.Bridge.send(m)
end

cc.exports.sdkbox = sdkbox or {}
sdkbox.bb = sdkbox.bb or {}
sdkbox.bb.plugin = sdkbox.bb.plugin or {}
sdkbox.bb.plugin.IronSource = IronSource
