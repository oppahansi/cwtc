import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

import '../../app/ad_helper.dart';
import '../../app/size_config.dart';
import '../../constants/constants.dart';
import 'char_class_button/char_class_button_view.dart';
import 'char_builds_dialog/char_builds_dialog.dart';
import 'char_class_viewmodel.dart';

class CharClassView extends StatefulWidget {
  const CharClassView({Key? key}) : super(key: key);

  @override
  State<CharClassView> createState() => _CharClassViewState();
}

class _CharClassViewState extends State<CharClassView> {
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
    return ViewModelBuilder<CharClassViewModel>.nonReactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black87,
            title: Text(model.getExpansionFull, style: const TextStyle(color: Colors.black87)),
            backgroundColor: model.getExpansionColor,
          ),
          body: Container(
            decoration: Constants.getBgDecoration(model.getRngBgImageFilePath),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (SizeConfig.screenHeight! <= 800 && model.getExpansionId == 2)
                      SizedBox(height: SizeConfig.safeBlockVertical!)
                    else
                      SizedBox(height: SizeConfig.safeBlockVertical! * 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CharClassesButtonView(charClassId: 0),
                        CharClassesButtonView(charClassId: 1),
                        CharClassesButtonView(charClassId: 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CharClassesButtonView(charClassId: 3),
                        CharClassesButtonView(charClassId: 4),
                        CharClassesButtonView(charClassId: 5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CharClassesButtonView(charClassId: 6),
                        CharClassesButtonView(charClassId: 7),
                        CharClassesButtonView(charClassId: 8),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.getExpansionId == 2 ? const CharClassesButtonView(charClassId: 9) : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical! * _getHeightFactor(model)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.folder, color: Colors.black),
                          label: const Text("Load Saved Builds", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                          onPressed: () => _showMyDialog(context),
                        )
                      ],
                    )
                  ],
                ),
                _displayAdd(model),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CharClassViewModel(),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const CharBuildsView();
      },
    );
  }

  Widget _displayAdd(CharClassViewModel model) {
    if (_isBannerAdReady) {
      Widget ad = Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
      );

      if (SizeConfig.screenHeight! > 480) {
        return ad;
      } else if (model.getExpansionId != 2) {
        return ad;
      }
    }

    return const SizedBox.shrink();
  }

  double _getHeightFactor(CharClassViewModel model) {
    double heightFactor = 5;

    if (SizeConfig.screenHeight! <= 480) {
      heightFactor = 1;
    } else if (SizeConfig.screenHeight! <= 600 && model.getExpansionId == 2) {
      heightFactor = 2;
    }

    return heightFactor;
  }
}
