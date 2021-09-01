#pragma once

#include <string>
#include <vector>
#include <map>

namespace sdkbox {
namespace bb {
namespace plugin {

    class IronSource {
    public:

        static void init();
        static void setListener(const std::function<void(const std::string& evt, const std::string& json)>& listener);
        static void launch(const std::string& appKey);
        static void validateIntegration();
        static void setConsent(bool b);
        static void setMetaData(const std::string& key, const std::string& val);
        static void setUserId(const std::string& uid);
        static void setSegment(const std::string& seg);
        static void setRewardedVideoServerParameters(const std::map<std::string, std::string>& params);
        static void clearRewardedVideoServerParameters();
        static void setOfferwallCustomParams(const std::map<std::string, std::string>& params);
        static void shouldTrackNetworkState(bool b);

        static void isRewardedVideoAvailable(
                const std::function<void(bool available)>& cb,
                const std::string& placement = "");
        static void showRewardedVideo(const std::string& placement = "");
        static void isRewardedVideoPlacementCapped(
                const std::function<void(bool available)>& cb,
                const std::string& placement = "");
        static void setDynamicUserId(const std::string& uid);

        static void loadInterstitial();
        static void isInterstitialReady(
                const std::function<void(bool available)>& cb,
                const std::string& placement = "");
        static void isInterstitialPlacementCapped(
                const std::function<void(bool available)>& cb,
                const std::string& placement = "");
        static void showInterstitial(const std::string& placement = "");

        static void loadBanner(const std::string& placement = "");
        static void destroyBanner();

        static void showOfferwall();
        static void getOfferwallCredits();
        static void setClientSideCallbacks(bool b);

    };

}
}
}
