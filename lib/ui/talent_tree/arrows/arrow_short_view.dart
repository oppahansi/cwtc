import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import '../../../ui/talent_tree/arrows/arrow_viewmodel.dart';

class ArrowShortView extends StatelessWidget {
  final Talent talent;
  final Talent dependee;

  const ArrowShortView({
    required this.talent,
    required this.dependee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ArrowViewModel>.reactive(
      builder: (context, model, child) {
        double width = SizeConfig.safeBlockHorizontal! * 20;
        double height = SizeConfig.safeBlockHorizontal! * 20;

        return Positioned(
          width: width,
          height: height,
          top: talent.row * SizeConfig.cellSize!,
          left: talent.column * SizeConfig.cellSize!,
          child: AlignPositioned(
            alignment: Alignment.bottomCenter,
            moveByChildHeight: .55,
            moveByChildWidth: -.1,
            child: Container(
              height: SizeConfig.safeBlockHorizontal! * 5,
              width: SizeConfig.safeBlockVertical! * 5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(model.getArrowShortImage),
                  colorFilter: model.getStateColor(talent, dependee),
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
