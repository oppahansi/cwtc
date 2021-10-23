import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../constants/arrow_painters.dart';
import '../../../data_models/talent.dart';
import '../talent_tree_viewmodel.dart';

class TalentView extends StatelessWidget {
  final Talent talent;
  final int talentTreePosition;

  const TalentView({required this.talentTreePosition, required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) {
        model.addTalent(talent);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            TextButton(
              onPressed: () {},
              child: Container(
                height: SizeConfig.safeBlockVertical! * 20,
                width: SizeConfig.safeBlockHorizontal! * 20,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(model.getIcon(talent.icon)),
                    colorFilter: model.isTalentDisabled(talent.id) ? const ColorFilter.mode(Colors.grey, BlendMode.saturation) : null,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 3,
                    color: model.isTalentDisabled(talent.id) ? Colors.grey : Colors.green.shade400,
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
                    color: model.isTalentDisabled(talent.id) ? Colors.grey : Colors.green.shade400,
                  ),
                ),
                child: Text(
                  model.getTalentPoints(talentTreePosition).toString(),
                  style: TextStyle(color: model.isTalentDisabled(talent.id) ? Colors.grey : Colors.green.shade400),
                ),
              ),
            ),
            AlignPositioned(
              child: model.talentEnablesAnother(talent.id)
                  ? CustomPaint(
                      size: Size(SizeConfig.safeBlockHorizontal! * 15, SizeConfig.safeBlockVertical! * 5),
                      painter: ArrowShortRightPainter(model.isTalentDisabled(talent.id)),
                    )
                  : const SizedBox.shrink(),
              alignment: Alignment.centerRight,
              moveByChildWidth: 0.5,
            )
          ],
        );
      },
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
