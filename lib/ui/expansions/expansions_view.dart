import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../../app/ad_helper.dart';
import '../../app/size_config.dart';
import '../../constants/constants.dart';
import '../../extensions/extensions.dart';
import '../widgets/app_title.dart';
import 'exapnsions_viewmodel.dart';
import 'expansions_button/expansions_button_view.dart';

class ExpansionsView extends StatefulWidget {
  const ExpansionsView({Key? key}) : super(key: key);

  @override
  State<ExpansionsView> createState() => _ExpansionsViewState();
}

class _ExpansionsViewState extends State<ExpansionsView> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ViewModelBuilder<ExpansionsViewModel>.nonReactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: Constants.getBgDecoration(model.getRngBgImage),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.safeBlockVertical! * 20),
                    const AppTitle(),
                    SizedBox(height: SizeConfig.safeBlockVertical! * 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ExpansionsButtonView(
                          expansionId: Expansions.vanilla.index,
                          expansionString: Expansions.vanilla.toShortString(),
                        ),
                        ExpansionsButtonView(
                          expansionId: Expansions.tbc.index,
                          expansionString: Expansions.tbc.toShortString(),
                        ),
                        ExpansionsButtonView(
                          expansionId: Expansions.wotlk.index,
                          expansionString: Expansions.wotlk.toShortString(),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExpansionsViewModel(),
    );
  }
}
