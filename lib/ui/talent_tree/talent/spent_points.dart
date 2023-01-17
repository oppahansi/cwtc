import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import 'spent_points_viewmodel.dart';

class SpentPoints extends StatelessWidget {
  final Talent talent;

  const SpentPoints({
    required this.talent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SpentPointsViewModel>.reactive(
      builder: (context, model, child) => AlignPositioned(
        alignment: Alignment.bottomRight,
        moveHorizontallyByChildHeight: -.2,
        moveVerticallyByChildWidth: -.2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              width: 2,
              color: model.getStateColor(talent),
            ),
          ),
          child: Text(
            "${model.getInvestedPointsAt(talent.specId, talent.index).toString()}/${talent.ranks.length}",
            style: TextStyle(
              color: model.getStateColor(talent),
              fontSize: SizeConfig.blockSizeHorizontal! * 3,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SpentPointsViewModel(),
    );
  }
}
