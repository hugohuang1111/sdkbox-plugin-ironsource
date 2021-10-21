package com.sdkbox.bb.bridge.plugin.ironsource;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.DisplayCutout;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.Window;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.ironsource.adapters.supersonicads.SupersonicConfig;
import com.ironsource.mediationsdk.ISBannerSize;
import com.ironsource.mediationsdk.IronSource;
import com.ironsource.mediationsdk.IronSourceBannerLayout;
import com.ironsource.mediationsdk.IronSourceSegment;
import com.ironsource.mediationsdk.integration.IntegrationHelper;
import com.ironsource.mediationsdk.logger.IronSourceError;
import com.ironsource.mediationsdk.model.Placement;
import com.ironsource.mediationsdk.sdk.BannerListener;
import com.ironsource.mediationsdk.sdk.InterstitialListener;
import com.ironsource.mediationsdk.sdk.OfferwallListener;
import com.ironsource.mediationsdk.sdk.RewardedVideoListener;
import com.sdkbox.bb.bridge.core.Msg;
import com.sdkbox.bb.bridge.core.PluginBase;

public class PluginIronSource extends PluginBase implements Application.ActivityLifecycleCallbacks {
    private static final String TAG = "PluginIronSource";
    private String devKey = ""; // gQHXnL6H3dccTbdNcLywNj
    private Application application = null;
    private Activity activity = null;
    private IronSourceBannerLayout mBanner = null;

    public PluginIronSource(Context ctx) {
        super(ctx);
    }

    @Override
    public void onApplicationCreate(Application app) {
        application = app;
    }

    @Override
    public void onActivityCreate(Activity act) {
        this.activity = act;
        super.onActivityCreate(act);
    }

    @Override
    public Activity getActivity() {
        if (null != activity) {
            return activity;
        }

        return super.getActivity();
    }

    public void launch(Msg msg) {
        String appKey = msg.getValueString (0);

        IronSource.setRewardedVideoListener(new RewardedVideoListener() {

            @Override
            public void onRewardedVideoAdOpened() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdOpened");
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdClosed() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdClosed");
                sendToNative(msg);

            }

            @Override
            public void onRewardedVideoAvailabilityChanged(boolean b) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAvailabilityChanged");
                JSONObject jsonObject = new JSONObject();

                try {
                    jsonObject.put("availability", b);
                } catch (JSONException e) {
                }

                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdStarted() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdStarted");
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdEnded() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdEnded");
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdRewarded(Placement placement) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdRewarded");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("id", placement.getPlacementId());
                    jsonObject.put("name", placement.getPlacementName());
                    jsonObject.put("rewardAmount", placement.getRewardAmount());
                    jsonObject.put("rewardName", placement.getRewardName());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdShowFailed(IronSourceError ironSourceError) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdShowFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", ironSourceError.getErrorCode());
                    jsonObject.put("errorMsg", ironSourceError.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onRewardedVideoAdClicked(Placement placement) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onRewardedVideoAdClicked");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("id", placement.getPlacementId());
                    jsonObject.put("name", placement.getPlacementName());
                    jsonObject.put("rewardAmount", placement.getRewardAmount());
                    jsonObject.put("rewardName", placement.getRewardName());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }
        });

        IronSource.setInterstitialListener(new InterstitialListener() {

            @Override
            public void onInterstitialAdReady() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdReady");
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdLoadFailed(IronSourceError ironSourceError) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdLoadFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", ironSourceError.getErrorCode());
                    jsonObject.put("errorMsg", ironSourceError.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdOpened() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdOpened");
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdClosed() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdClosed");
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdShowSucceeded() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdShowSucceeded");
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdShowFailed(IronSourceError ironSourceError) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdShowFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", ironSourceError.getErrorCode());
                    jsonObject.put("errorMsg", ironSourceError.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onInterstitialAdClicked() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onInterstitialAdClicked");
                sendToNative(msg);
            }
        });

        IronSource.setOfferwallListener(new OfferwallListener() {
            @Override
            public void onOfferwallAvailable(boolean b) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onOfferwallAvailable");
                msg.pushValue(b);
                sendToNative(msg);
            }

            @Override
            public void onOfferwallOpened() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onOfferwallOpened");
                sendToNative(msg);
            }

            @Override
            public void onOfferwallShowFailed(IronSourceError ironSourceError) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onOfferwallShowFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", ironSourceError.getErrorCode());
                    jsonObject.put("errorMsg", ironSourceError.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public boolean onOfferwallAdCredited(int credits, int totalCredits, boolean totalCreditsFlag) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onOfferwallAdCredited");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("credits", credits);
                    jsonObject.put("totalCredits", totalCredits);
                    jsonObject.put("totalCreditsFlag", totalCreditsFlag);
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
                return false;
            }

            @Override
            public void onGetOfferwallCreditsFailed(IronSourceError ironSourceError) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onGetOfferwallCreditsFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", ironSourceError.getErrorCode());
                    jsonObject.put("errorMsg", ironSourceError.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onOfferwallClosed() {
                Msg msg = createDefaultMsg();
                msg.pushValue("onOfferwallClosed");
                sendToNative(msg);
            }
        });

        IronSource.init(getActivity(), appKey);


        mBanner = IronSource.createBanner(getActivity(), ISBannerSize.SMART);

        mBanner.setBannerListener(new BannerListener() {
            @Override
            public void onBannerAdLoaded() {
                // Called after a banner ad has been successfully loaded
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdLoaded");
                sendToNative(msg);
            }

            @Override
            public void onBannerAdLoadFailed(IronSourceError error) {
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdLoadFailed");
                JSONObject jsonObject = new JSONObject();
                try {
                    jsonObject.put("errorCode", error.getErrorCode());
                    jsonObject.put("errorMsg", error.getErrorMessage());
                } catch (JSONException e) {
                }
                msg.pushValue(jsonObject.toString());
                sendToNative(msg);
            }

            @Override
            public void onBannerAdClicked() {
                // Called after a banner has been clicked.
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdClicked");
                sendToNative(msg);
            }

            @Override
            public void onBannerAdScreenPresented() {
                // Called when a banner is about to present a full screen content.
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdScreenPresented");
                sendToNative(msg);
            }

            @Override
            public void onBannerAdScreenDismissed() {
                // Called after a full screen content has been dismissed
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdScreenDismissed");
                sendToNative(msg);
            }

            @Override
            public void onBannerAdLeftApplication() {
                // Called when a user would be taken out of the application context.
                Msg msg = createDefaultMsg();
                msg.pushValue("onBannerAdLeftApplication");
                sendToNative(msg);
            }
        });
    }

    public void validateIntegration(Msg msg) {
        Activity act = this.getActivity();
        if (null == act) {
            return;
        }
        IntegrationHelper.validateIntegration(act);
    }

    public void setConsent(Msg msg) {
        boolean b = msg.getValueBoolean(0);
        IronSource.setConsent(b);
    }

    public void setMetaData(Msg msg) {
        String key = msg.getValueString (0);
        String val = msg.getValueString (1);
        IronSource.setMetaData(key, val);
    }

    public void setUserId(Msg msg) {
        String uid = msg.getValueString(0);
        IronSource.setUserId(uid);
    }

    public void setSegment(Msg msg) {
        JSONObject param = msg.getValueJson(0);

        // Create segment object
        IronSourceSegment mIronSegment = new IronSourceSegment();

        int i = param.optInt ("age", -1);
        if (i > 0) {
            mIronSegment.setAge(i);
        }
        String s = param.optString ("gender", "");
        if (s.length() > 0) {
            mIronSegment.setGender(s);
        }
        i = param.optInt ("level", -1);
        if (i > 0) {
            mIronSegment.setLevel(i);
        }
        long l = param.optLong ("userCreationDate", -1);
        if (l > 0) {
            mIronSegment.setUserCreationDate(l);
        }
        double d = param.optLong ("IAPTotal", -1);
        if (d > 0) {
            mIronSegment.setIAPTotal(d);
        }
        boolean b = param.optBoolean ("isPaying", false);
        mIronSegment.setIsPaying(b);
        JSONObject customs = param.optJSONObject ("custom");
        if (null != customs) {
            Iterator<String> it = customs.keys();
            while(it.hasNext()) {
                String key = it.next();
                String val = customs.optString(key, "");
                mIronSegment.setCustom(key, val);
            }
        }

        IronSource.setSegment(mIronSegment);
    }

    public void setRewardedVideoServerParameters(Msg msg) {
        JSONObject param = msg.getValueJson(0);
        if (null == param) {
            return;
        }
        Map<String, String> paramMap = json2HashMap(param);

        IronSource.setRewardedVideoServerParameters(paramMap);
    }

    public void clearRewardedVideoServerParameters(Msg msg) {
        IronSource.clearRewardedVideoServerParameters();
    }

    public void setOfferwallCustomParams(Msg msg) {
        JSONObject param = msg.getValueJson(0);
        if (null == param) {
            return;
        }
        Map<String, String> owParams = json2HashMap(param);

        SupersonicConfig.getConfigObj().setOfferwallCustomParams(owParams);
    }

    public void shouldTrackNetworkState(Msg msg) {
        boolean b = msg.getValueBoolean(0);
        IronSource.shouldTrackNetworkState(this.getActivity(), b);
    }

    public void isRewardedVideoAvailable(Msg msg) {
        msg.cleanValue();
        msg.pushValue(IronSource.isRewardedVideoAvailable());
        sendToNative(msg);
    }

    public void showRewardedVideo(Msg msg) {
        String s = msg.getValueString(0);
        IronSource.showRewardedVideo(s);
    }

    public void isRewardedVideoPlacementCapped(Msg msg) {
        String s = msg.getValueString(0);
        msg.cleanValue();
        msg.pushValue(IronSource.isRewardedVideoPlacementCapped(s));
        sendToNative(msg);
    }

    public void setDynamicUserId(Msg msg) {
        String s = msg.getValueString(0);
        IronSource.setDynamicUserId(s);
    }

    public void loadInterstitial(Msg msg) {
        IronSource.loadInterstitial();
    }

    public void isInterstitialReady(Msg msg) {
        msg.cleanValue();
        msg.pushValue(IronSource.isInterstitialReady());
        sendToNative(msg);
    }

    public void isInterstitialPlacementCapped(Msg msg) {
        String s = msg.getValueString(0);
        msg.cleanValue();
        msg.pushValue(IronSource.isInterstitialPlacementCapped(s));
        sendToNative(msg);
    }

    public void showInterstitial(Msg msg) {
        String s = msg.getValueString(0);
        IronSource.showInterstitial(s);
    }

    public void loadBanner(Msg msg) {
        if (null == mBanner) {
            return;
        }
        String alignment = msg.getValueString(0);
        String placement = msg.getValueString(1);
        if (null == placement || 0 == placement.length()) {
            IronSource.loadBanner(mBanner);
        } else {
            IronSource.loadBanner(mBanner, placement);
        }
        addToRootView(getActivity(), mBanner, alignment);
    }

    public void destroyBanner(Msg msg) {
        if (null == mBanner) {
            return;
        }
        IronSource.destroyBanner(mBanner);
    }

    public void showOfferwall(Msg msg) {
        IronSource.showOfferwall();
    }

    public void getOfferwallCredits(Msg msg) {
        IronSource.getOfferwallCredits();
    }

    public void setClientSideCallbacks(Msg msg) {
        boolean b = msg.getValueBoolean(0);
        SupersonicConfig.getConfigObj().setClientSideCallbacks(b);
    }



    public static int[] getSafeInsets(Activity activity) {
        final int[] safeInsets = new int[]{0, 0, 0, 0};
        if (null == activity) {
            return safeInsets;
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            Window cocosWindow = activity.getWindow();
            DisplayCutout displayCutout = cocosWindow.getDecorView().getRootWindowInsets().getDisplayCutout();
            // Judge whether it is cutouts (aka notch) screen phone by judge cutout equle to null
            if (displayCutout != null) {
                List<Rect> rects = displayCutout.getBoundingRects();
                // Judge whether it is cutouts (aka notch) screen phone by judge cutout rects is null or zero size
                if (rects != null && rects.size() != 0) {
                    safeInsets[0] = displayCutout.getSafeInsetBottom();
                    safeInsets[1] = displayCutout.getSafeInsetLeft();
                    safeInsets[2] = displayCutout.getSafeInsetRight();
                    safeInsets[3] = displayCutout.getSafeInsetTop();
                }
            }
        }

        return safeInsets;
    }

    static private void addToRootView(Activity activity, View bannerAd, String alignment) {
        ViewGroup parent = (ViewGroup) bannerAd.getParent();
        if (null != parent) {
            return;
        }
        RelativeLayout layout = new RelativeLayout(activity);
        RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.FILL_PARENT, RelativeLayout.LayoutParams.FILL_PARENT);
        int[] cutouts = getSafeInsets(activity);
        lp.setMargins(cutouts[1], cutouts[3], cutouts[2], cutouts[0]);
        activity.addContentView(layout, lp);
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);

        if ("top".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
            params.addRule(RelativeLayout.CENTER_HORIZONTAL);
        } else if ("bottom".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
            params.addRule(RelativeLayout.CENTER_HORIZONTAL);
        } else if ("right".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
            params.addRule(RelativeLayout.CENTER_VERTICAL);
        } else if ("left".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
            params.addRule(RelativeLayout.CENTER_VERTICAL);
        } else if ("center".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.CENTER_IN_PARENT);
        } else if ("top_left".equalsIgnoreCase(alignment)
                || "left_top".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
            params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
        } else if ("top_right".equalsIgnoreCase(alignment)
                || "right_top".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
            params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        } else if ("bottom_left".equalsIgnoreCase(alignment)
                || "left_bottom".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
            params.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
        } else if ("bottom_right".equalsIgnoreCase(alignment)
                || "right_bottom".equalsIgnoreCase(alignment)) {
            params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
            params.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
        } else {
            params.addRule(RelativeLayout.ALIGN_PARENT_TOP);
            params.addRule(RelativeLayout.CENTER_HORIZONTAL);
        }

        layout.addView(bannerAd, params);
        layout.setFocusable(false);
    }


    private HashMap<String, String> json2HashMap(JSONObject jsonObj) {
        if (null == jsonObj) {
            return null;
        }
        HashMap<String, String> map = new HashMap<String, String>();
        for (Iterator<String> it = jsonObj.keys(); it.hasNext(); ) {
            String key = it.next();
            try {
                Object valObj = jsonObj.get(key);
                if (valObj instanceof String) {
                    map.put(key, (String)valObj);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        return map;
    }




    @Override
    public void onActivityCreated(@NonNull Activity activity, @Nullable Bundle bundle) {
    }

    @Override
    public void onActivityStarted(@NonNull Activity activity) {

    }

    @Override
    public void onActivityResumed(@NonNull Activity activity) {
        IronSource.onResume(activity);
    }

    @Override
    public void onActivityPaused(@NonNull Activity activity) {
        IronSource.onPause(activity);
    }

    @Override
    public void onActivityStopped(@NonNull Activity activity) {

    }

    @Override
    public void onActivitySaveInstanceState(@NonNull Activity activity, @NonNull Bundle bundle) {

    }

    @Override
    public void onActivityDestroyed(@NonNull Activity activity) {

    }
}
