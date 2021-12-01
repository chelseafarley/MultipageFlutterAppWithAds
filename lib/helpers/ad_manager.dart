import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isIOS ? "ca-app-pub-3940256099942544/2934735716" : "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );

    _bannerAd?.load();
  }

  void loadInterstitialAd() {
    String interstitialAdId = Platform.isIOS ? "ca-app-pub-3940256099942544/4411468910" : "ca-app-pub-3940256099942544/1033173712";

    InterstitialAd.load(
      adUnitId: interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      )
    );
  }

  void addAds(bool interstitial, bool bannerAd) {
    if (interstitial) {
      loadInterstitialAd();
    }

    if (bannerAd) {
      loadBannerAd();
    }
  }

  void showInterstitial() {
    _interstitialAd?.show();
  }

  BannerAd? getBannerAd() {
    return _bannerAd;
  }

  void disposeAds() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}