import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import '../talent_tree_viewmodel.dart';

class TalentView extends StatelessWidget {
  const TalentView({required this.talentTreePosition, required this.talent, Key? key}) : super(key: key);

  final Talent talent;
  final int talentTreePosition;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) {
        model.addTalent(talent);
        return Positioned(
          top: talent.row * SizeConfig.cellSize!,
          left: talent.column * SizeConfig.cellSize!,
          child: TextButton(
            onPressed: () {},
            child: Container(
              width: SizeConfig.cellSize! * .75,
              height: SizeConfig.cellSize! * .75,
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
        );
      },
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
