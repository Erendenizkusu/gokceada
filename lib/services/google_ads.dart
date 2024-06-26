import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds with ChangeNotifier{
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;
  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2707472203466324/8735919613',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            showAfterLoad = true;
            interstitialAd = ad;
            if(showAfterLoad) showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
          },
        ));
  }
  void showInterstitialAd(){
    if(interstitialAd != null){
      interstitialAd!.show();
    }
  }
  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-2707472203466324/5244738491',
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )
      ..load();
  }
}