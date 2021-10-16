import 'package:align_positioned/align_positioned.dart';
import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/arrow_painters.dart';
import '../../../data_models/talent.dart';
import 'talent_viewmodel.dart';

class TalentView extends StatelessWidget {
  final Talent talent;

  const TalentView({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<TalentViewModel>.reactive(
      builder: (context, model, child) => Stack(
        clipBehavior: Clip.none,
        children: [
          TextButton(
            onPressed: () {
              model.isTalentDisabled() ? null : model.incrementTalentPoints();
            },
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            child: Container(
              height: SizeConfig.safeBlockVertical! * 32,
              width: SizeConfig.safeBlockHorizontal! * 32,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(model.getIcon(talent.icon)),
                  colorFilter: model.isTalentDisabled() ? const ColorFilter.mode(Colors.grey, BlendMode.saturation) : null,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 3,
                  color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400,
                ),
              ),
            ),
          ),
          AlignPositioned(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  width: 2,
                  color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400,
                ),
              ),
              child: Text(
                model.getTalentPoints.toString(),
                style: TextStyle(color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400),
              ),
            ),
          ),
          AlignPositioned(
            child: CustomPaint(
              size: Size(
                  SizeConfig.safeBlockHorizontal! * 32,
                  (SizeConfig.safeBlockHorizontal! * 32 * 0.3333333333333333)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: ArrowShortRight(),
            ),
            alignment: Alignment.centerRight,
            moveByChildWidth: 0.15,
          ),
        ],
      ),
      viewModelBuilder: () => TalentViewModel(talent),
    );
  }
}
