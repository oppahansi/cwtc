import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:classic_wow_talent_calculator_stacked/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../talent_tree_viewmodel.dart';

class TalentSpecView extends StatelessWidget {
  const TalentSpecView({
    required this.specId,
    required this.talentImageWidth,
    Key? key,
  }) : super(key: key);

  final int specId;
  final double talentImageWidth;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) {
        model.setSpecId(specId);

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.cellSize! * model.getMaxTalentTreeRows.toDouble() + 40,
                ),
                child: Container(
                  decoration: Constants.getBgDecoration(model.getBGImage),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Stack(
                    children: [
                      ...List.generate(model.getTreeLength, (index) {
                        return model.getTalentForTreePosition(index, talentImageWidth);
                      })
                    ],
                  ),
                ),
              ),
            );
          },
        );
        // return Container(
        //   decoration: Constants.getBgDecoration(model.getBGImage),
        //   child: Stack(
        //     children: [
        //       ...List.generate(model.getTreeLength, (index) {
        //         return model.getTalentForTreePosition(index, talentImageWidth);
        //       })
        //     ],
        //   ),
        // );
      },
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
