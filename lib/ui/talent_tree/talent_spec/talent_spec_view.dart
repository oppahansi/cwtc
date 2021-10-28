import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../constants/constants.dart';
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
                  decoration: Constants.getBgDecoration(model.getSpecBGImage),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Stack(
                    children: [
                      ...List.generate(model.getTreeLength, (index) {
                        return model.getTalentForIndex(index, talentImageWidth);
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
