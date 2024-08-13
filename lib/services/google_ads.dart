import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class GoogleAds with ChangeNotifier {
  InterstitialAd? interstitialAd;
  BannerAd? bannerAd;

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2707472203466324/8735919613'; // Android interstitial ad unit ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2707472203466324/6162340510'; // iOS interstitial ad unit ID
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2707472203466324/5244738491'; // Android banner ad unit ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2707472203466324/7991832474'; // iOS banner ad unit ID
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }
  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
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
      adUnitId: bannerAdUnitId,
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