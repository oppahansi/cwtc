import 'package:flutter/material.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import 'button.dart';
import 'spent_points.dart';

class TalentView extends StatelessWidget {
  final Talent talent;

  const TalentView({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.safeBlockHorizontal! * 20;
    double height = SizeConfig.safeBlockHorizontal! * 20;

    return Positioned(
      width: width,
      height: height,
      top: talent.row * SizeConfig.cellSize!,
      left: talent.column * SizeConfig.cellSize!,
      child: Stack(
        children: [
          TalentButton(talent: talent),
          SpentPoints(talent: talent),
        ],
      ),
    );
  }
}
