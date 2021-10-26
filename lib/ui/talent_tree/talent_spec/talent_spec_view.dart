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
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) {
        model.setSpecId(specId);

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(model.getBGImage),
              fit: BoxFit.fill,
            ),
          ),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 0.0,
            children: [
              ...List.generate(model.getTreeLength, (index) {
                return model.getTalentForTreePosition(index, talentImageWidth);
              }),
            ],
          ),
        );
      },
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
