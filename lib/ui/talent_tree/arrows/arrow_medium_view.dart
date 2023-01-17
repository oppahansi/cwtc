import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import '../../../ui/talent_tree/arrows/arrow_viewmodel.dart';

class ArrowMediumView extends StatelessWidget {
  final Talent talent;
  final Talent dependee;

  const ArrowMediumView({
    required this.talent,
    required this.dependee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ArrowViewModel>.reactive(
      builder: (context, model, child) {
        double width = SizeConfig.safeBlockHorizontal! * 8;
        double height = SizeConfig.safeBlockHorizontal! * 27.75;

        return Positioned(
          width: width,
          height: height,
          top: talent.row * SizeConfig.cellSize!,
          left: talent.column * SizeConfig.cellSize!,
          child: AlignPositioned(
            alignment: Alignment.bottomCenter,
            moveByChildHeight: .63,
            moveByChildWidth: .6,
            child: Container(
              height: SizeConfig.safeBlockVertical! * 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(model.getArrowMediumImage),
                  colorFilter: model.getStateColor(talent, dependee),
                  scale: 1.5,
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ArrowViewModel(),
    );
  }
}
