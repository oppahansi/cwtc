import 'build_sequence_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/sequence_point.dart' as app_model;
import '../../../data_models/talent.dart';

class SequencePointCard extends StatelessWidget {
  final app_model.SequencePoint sequencePoint;

  const SequencePointCard({required this.sequencePoint, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuildSequenceViewModel>.reactive(
      builder: (context, model, child) {
        Talent talent = model.getTalentForPosition(sequencePoint.specId, sequencePoint.talentIndex ~/ 4, sequencePoint.talentIndex % 4);
        double width = SizeConfig.safeBlockHorizontal! * 17.5;
        double height = SizeConfig.safeBlockHorizontal! * 17.5;

        return Card(
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (sequencePoint.sequencePoint + 9).toString(),
                  style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 5),
                ),
                Container(
                  width: width / 2,
                  height: height / 2,
                  margin: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal!),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(model.getTalentIcon(talent.icon)),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(width: 3),
                  ),
                )
              ],
            ),
            title: Text(talent.name, style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 3)),
            trailing: Text("${sequencePoint.rank.toString()}/${talent.ranks.length}"),
            subtitle: Text(model.getSpecName(sequencePoint.specId), style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 2.5)),
          ),
        );
      },
      viewModelBuilder: () => BuildSequenceViewModel(),
    );
  }
}
