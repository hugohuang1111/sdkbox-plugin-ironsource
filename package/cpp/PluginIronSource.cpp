#include "./json.hpp"
#include "PluginIronSource.h"
#include "Bridge/Bridge.hpp"
#include "Bridge/Msg.hpp"

namespace sdkbox {
namespace bb {
namespace plugin {


void IronSource::init() {
    sdkbox::bb::Bridge::init();

#ifdef ANDROID
    sdkbox::bb::Bridge::addPlugin("IronSource", "com.sdkbox.bb.bridge.plugin.ironsource.PluginIronSource");
#elif __APPLE__
    sdkbox::bb::Bridge::addPlugin("IronSource", "BBPluginIronSource");
#else
    #error "Unknown support platform"
#endif
}

void IronSource::setListener(const std::function<void(const std::string& evt, const std::string& json)>& listener) {
    sdkbox::bb::Bridge::onRecv([=](const Msg& msg) {
        const auto& pluginName = msg.getPlugin();
        const auto& valEvt = msg.getValue(0);
        if (0 != pluginName.compare("IronSource")) {
            return ;
        }
        listener(valEvt.stringValue(), msg.getValue(1).stringValue());
    });
}

void IronSource::launch(const std::string& appKey) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "launch");
    msg.pushValue(appKey);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::validateIntegration() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "validateIntegration");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setConsent(bool b) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setConsent");
    msg.pushValue(b);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setMetaData(const std::string& key, const std::string& val) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setMetaData");
    msg.pushValue(key);
    msg.pushValue(val);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setUserId(const std::string& uid) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setUserId");
    msg.pushValue(uid);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setSegment(const std::string& seg) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setSegment");
    msg.pushValue(seg);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setRewardedVideoServerParameters(const std::map<std::string, std::string>& params) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setRewardedVideoServerParameters");
    nlohmann::json j;
    for (const auto & param : params) {
        j[param.first] = param.second;
    }
    if (!j.empty()) { msg.pushValue(j.dump()); }
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::clearRewardedVideoServerParameters() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "clearRewardedVideoServerParameters");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setOfferwallCustomParams(const std::map<std::string, std::string>& params) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setOfferwallCustomParams");
    nlohmann::json j;
    for (const auto & param : params) {
        j[param.first] = param.second;
    }
    if (!j.empty()) { msg.pushValue(j.dump()); }
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::shouldTrackNetworkState(bool b) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "shouldTrackNetworkState");
    msg.pushValue(b);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::isRewardedVideoAvailable(
        const std::function<void(bool available)>& cb,
        const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "isRewardedVideoAvailable");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg, [=](const Msg& rMsg) {
        bool b = rMsg.getValue(0).booleanValue();
        cb(b);
    });
}

void IronSource::showRewardedVideo(const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "showRewardedVideo");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::isRewardedVideoPlacementCapped(
        const std::function<void(bool available)>& cb,
        const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "isRewardedVideoPlacementCapped");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg, [=](const Msg& rMsg) {
        bool b = rMsg.getValue(0).booleanValue();
        cb(b);
    });
}

void IronSource::setDynamicUserId(const std::string& uid) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setDynamicUserId");
    msg.pushValue(uid);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::loadInterstitial() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "loadInterstitial");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::isInterstitialReady(
        const std::function<void(bool b)>& cb,
        const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "isInterstitialReady");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg, [=](const Msg& rMsg) {
        bool b = rMsg.getValue(0).booleanValue();
        cb(b);
    });
}

void IronSource::isInterstitialPlacementCapped(
        const std::function<void(bool available)>& cb,
        const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "isInterstitialPlacementCapped");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg);
    sdkbox::bb::Bridge::send(msg, [=](const Msg& rMsg) {
        bool b = rMsg.getValue(0).booleanValue();
        cb(b);
    });
}

void IronSource::showInterstitial(const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "showInterstitial");
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::loadBanner(const std::string& alignment, const std::string& placement) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "loadBanner");
    msg.pushValue(alignment);
    msg.pushValue(placement);
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::destroyBanner() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "destroyBanner");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::showOfferwall() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "showOfferwall");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::getOfferwallCredits() {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "getOfferwallCredits");
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setClientSideCallbacks(bool b) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setClientSideCallbacks");
    msg.pushValue(b);
    sdkbox::bb::Bridge::send(msg);
}

/*
void IronSource::getIronSourceUID(const std::function<void(const std::string& IronSourceID)>& cb) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "getIronSourceUID");
    sdkbox::bb::Bridge::send(msg, [=](const Msg& rMsg) {
        std::string IronSourceID = rMsg.getValue(0).stringValue();
        cb(IronSourceID);
    });
}

void IronSource::collectASA(bool b) {
#ifdef __APPLE__
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "collectASA");
    msg.pushValue(b);
    sdkbox::bb::Bridge::send(msg);
#endif
}

void IronSource::setResolveDeepLinkURLs(const std::vector<std::string>& urls) {
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setResolveDeepLinkURLs");
    nlohmann::json j;
    for (auto it = urls.begin(); it != urls.end(); ++it) {
        j.push_back(*it);
    }
    msg.pushValue(j.dump());
    sdkbox::bb::Bridge::send(msg);
}

void IronSource::setImeiData(const std::string& data) {
#ifdef ANDROID
    sdkbox::bb::Msg msg = sdkbox::bb::Msg("IronSource", "setImeiData");
    msg.pushValue(data);
    sdkbox::bb::Bridge::send(msg);
#endif
}
*/


}
}
}
