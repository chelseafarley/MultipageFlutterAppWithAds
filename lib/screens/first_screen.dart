import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multipage_app_with_ads/screens/second_screen.dart';
import '../helpers/ad_manager.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({Key? key, required this.title}) : super(key: key) {
    adManager.addAds(true, true, true);
  }

  final String title;
  final adManager = AdManager();  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              adManager.disposeAds();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SecondScreen(
                  title: 'Flutter Multipage Ad Demo'
                )
              ));
            },
            child: const Text('Go to Second Screen'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              adManager.showInterstitial();
            },
            child: const Text('Show Interstitial'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              adManager.showRewardedAd();
            },
            child: const Text('Show Rewarded Ad'),
          ),
          const SizedBox(height: 32),
          Container(
            alignment: Alignment.center,
            child: AdWidget(ad: adManager.getBannerAd()!),
            width: adManager.getBannerAd()?.size.width.toDouble(),
            height: adManager.getBannerAd()?.size.height.toDouble(),
          )
        ]
      )
    );
  }
}