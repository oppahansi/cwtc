import 'expansions_button/expansions_button_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../widgets/app_title.dart';
//import '../../app/ads.dart';
import '../../app/size_config.dart';
import '../../constants/constants.dart';
import 'exapnsions_viewmodel.dart';

class ExpansionsView extends StatefulWidget {
  const ExpansionsView({Key? key}) : super(key: key);

  @override
  State<ExpansionsView> createState() => _ExpansionsViewState();
}

class _ExpansionsViewState extends State<ExpansionsView> {
  //late BannerAd _bottomBannerAd;

  // bool _isBottomBannerAdLoaded = false;

  // void _createBottomBannerAd() {
  //   _bottomBannerAd = BannerAd(
  //     adUnitId: AdManager.bannerAdUnitId,
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBottomBannerAdLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //   _bottomBannerAd.load();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _createBottomBannerAd();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _bottomBannerAd.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ExpansionsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.getRngBgImageFilePath),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppTitle(),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ExpansionsButtonView(expansionId: Expansions.vanilla.index, expansionString: Expansions.vanilla.toShortString()),
                    ExpansionsButtonView(expansionId: Expansions.tbc.index, expansionString: Expansions.tbc.toShortString()),
                    ExpansionsButtonView(expansionId: Expansions.wotlk.index, expansionString: Expansions.wotlk.toShortString()),
                  ],
                  // TODO add load button for loading saved talent build
                  // TODO add settings button to configure app
                ),
                const SizedBox(height: 75),
                // _isBottomBannerAdLoaded
                //     ? SizedBox(
                //         height: _bottomBannerAd.size.height.toDouble(),
                //         width: _bottomBannerAd.size.width.toDouble(),
                //         child: AdWidget(ad: _bottomBannerAd),
                //       )
                //     : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExpansionsViewModel(),
    );
  }
}
