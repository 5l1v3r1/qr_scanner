import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;

  InterstitialAd interstitialAd;
  BannerAd banner;
  BannerAd banner2;
  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      //nonPersonalizedAds: true,
    );
  }

  //'ca-app-pub-4694190778906605/8642578056',
  showBannerBottom() {
    banner = BannerAd(
        adUnitId: 'ca-app-pub-4694190778906605/8642578056',
        size: AdSize.banner,
        targetingInfo: _targetingInfo);

    banner
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  showBannerTop() {
    banner2 = BannerAd(
        adUnitId: 'ca-app-pub-4694190778906605/8642578056',
        size: AdSize.banner,
        targetingInfo: _targetingInfo);

    banner2
      ..load()
      ..show(anchorType: AnchorType.top, anchorOffset: 23);
  }

//'ca-app-pub-4694190778906605/5989312798',
  showIntesitial() {
    interstitialAd = InterstitialAd(
        adUnitId: 'ca-app-pub-4694190778906605/5989312798',
        targetingInfo: _targetingInfo);

    interstitialAd
      ..load()
      ..show();
  }

  disposeAllAdverTop() async {
    await banner2?.dispose();
  }

  disposeAllAdverBottom() async {
    await banner?.dispose();
  }
}
