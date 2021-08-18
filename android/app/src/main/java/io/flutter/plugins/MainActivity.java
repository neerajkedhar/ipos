package my.app.path;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    flutterEngine.getPlugins().add(new GoogleMobileAdsPlugin());
   super.configureFlutterEngine(flutterEngine);

    GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", NativeAdFactoryExample());
  }

  @Override
  public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
    GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
  }
}

class NativeAdFactoryExample implements NativeAdFactory {

    private final LayoutInflater layoutInflater;

 NativeAdFactoryExample(LayoutInflater layoutInflater) {
   this.layoutInflater = layoutInflater;
 }

    @Override
    public NativeAdView createNativeAd(
        NativeAd nativeAd, Map<String, Object> customOptions) {
            final NativeAdView adView =
            (NativeAdView) layoutInflater.inflate(R.layout.my_native_ad, null);
        final TextView headlineView = adView.findViewById(R.id.ad_headline);
        final TextView bodyView = adView.findViewById(R.id.ad_body);
     
        headlineView.setText(nativeAd.getHeadline());
        bodyView.setText(nativeAd.getBody());
     
        adView.setBackgroundColor(Color.YELLOW);
     
        adView.setNativeAd(nativeAd);
        adView.setBodyView(bodyView);
        adView.setHeadlineView(headlineView);
        return adView;
    }
  }