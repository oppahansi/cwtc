import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

import '../../../app/ad_helper.dart';
import '../../../app/size_config.dart';
import '../../../constants/constants.dart';
import '../../../data_models/dependency.dart';
import '../../../data_models/talent.dart';
import '../../../ui/talent_tree/spec/spec_viewmodel.dart';
import '../../talent_tree/arrows/arrow_left_long_view.dart';
import '../../talent_tree/arrows/arrow_left_medium_view.dart';
import '../../talent_tree/arrows/arrow_left_short_view.dart';
import '../../talent_tree/arrows/arrow_long_view.dart';
import '../../talent_tree/arrows/arrow_longest_view.dart';
import '../../talent_tree/arrows/arrow_medium_view.dart';
import '../../talent_tree/arrows/arrow_right_long_view.dart';
import '../../talent_tree/arrows/arrow_right_medium_view.dart';
import '../../talent_tree/arrows/arrow_right_short_view.dart';
import '../../talent_tree/arrows/arrow_short_view.dart';

class SpecView extends StatefulWidget {
  const SpecView({
    required this.specId,
    required this.talentImageWidth,
    required this.appAndTabBarHeight,
    Key? key,
  }) : super(key: key);

  final int specId;
  final double talentImageWidth;
  final double appAndTabBarHeight;

  @override
  State<SpecView> createState() => _SpecViewState();
}

class _SpecViewState extends State<SpecView> {
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
    return ViewModelBuilder<SpecViewModel>.reactive(
      builder: (context, model, child) {
        model.resetTalentIndex();

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            double height = SizeConfig.cellSize! * model.getMaxTalentTreeRows.toDouble() + (widget.appAndTabBarHeight / 1.5);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: Container(
                  decoration: Constants.getBgDecoration(model.getSpecBGImage(widget.specId)),
                  padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal! * 4, top: SizeConfig.safeBlockHorizontal! * 3),
                  child: Stack(
                    children: [
                      ...List.generate(model.getTreeLength, (index) {
                        return model.getTalentViewForIndex(widget.specId, index, widget.talentImageWidth);
                      }),
                      ..._buildArrows(model),
                      if (_isBannerAdReady)
                        Positioned(
                          top: height - _bannerAd.size.height.toDouble() * 1.25,
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
            );
          },
        );
      },
      viewModelBuilder: () => SpecViewModel(),
    );
  }

  List<Widget> _buildArrows(SpecViewModel model) {
    List<Widget> arrows = List.empty(growable: true);

    for (int i = 0, talentIndex = 0; i < model.getTreeLength; i++) {
      if (!model.isPositionEmptyAt(widget.specId, i)) {
        Talent talent = model.getTalentForIndex(widget.specId, talentIndex++);
        List<Dependency> dependencies = model.getDependencies(talent.id);

        for (Dependency dependency in dependencies) {
          Talent dependee = model.getTalentWithId(widget.specId, dependency.talentId);

          switch (dependency.arrowType) {
            case 0:
              arrows.add(ArrowShortView(talent: talent, dependee: dependee));
              break;
            case 1:
              arrows.add(ArrowRightShortView(talent: talent, dependee: dependee));
              break;
            case 2:
              arrows.add(ArrowLeftShortView(talent: talent, dependee: dependee));
              break;
            case 3:
              arrows.add(ArrowMediumView(talent: talent, dependee: dependee));
              break;
            case 4:
              arrows.add(ArrowRightMediumView(talent: talent, dependee: dependee));
              break;
            case 5:
              arrows.add(ArrowLeftMediumView(talent: talent, dependee: dependee));
              break;
            case 6:
              arrows.add(ArrowLongView(talent: talent, dependee: dependee));
              break;
            case 7:
              arrows.add(ArrowRightLongView(talent: talent, dependee: dependee));
              break;
            case 8:
              arrows.add(ArrowLeftLongView(talent: talent, dependee: dependee));
              break;
            case 9:
              arrows.add(ArrowLongestView(talent: talent, dependee: dependee));
              break;
          }
        }
      }
    }

    return arrows;
  }
}
