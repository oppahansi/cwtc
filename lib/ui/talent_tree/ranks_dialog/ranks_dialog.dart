import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import 'ranks_dialog_viewmodel.dart';

class RanksDialog extends StatelessWidget {
  final Talent talent;

  const RanksDialog({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.safeBlockHorizontal! * 17.5;
    double height = SizeConfig.safeBlockHorizontal! * 17.5;

    return ViewModelBuilder<RanksDialogViewModel>.reactive(
      builder: (context, model, child) {
        int investedPoints = model.getInvestedPointsAt(talent.specId, talent.index);
        String currentRankDesc = investedPoints == 0 ? "" : talent.ranks[investedPoints == 0 ? investedPoints : investedPoints - 1].desc;
        String nextRankDesc = talent.ranks[investedPoints == talent.ranks.length ? investedPoints - 1 : investedPoints].desc;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: model.getCharClassColor,
            actionsOverflowButtonSpacing: 10,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                onPressed: !model.canRemovePointAt(talent.specId, talent.index)
                    ? null
                    : model.isTalentAvailableAt(talent.specId, talent.index)
                        ? () {
                            model.removePointAt(talent.specId, talent.index);
                            investedPoints = model.getInvestedPointsAt(talent.specId, talent.index);
                            setState(() {
                              currentRankDesc = investedPoints == 0 ? "" : talent.ranks[investedPoints == 0 ? investedPoints : investedPoints - 1].desc;
                              nextRankDesc = talent.ranks[investedPoints == talent.ranks.length ? investedPoints - 1 : investedPoints].desc;
                            });
                          }
                        : null,
                child: const Icon(Icons.remove, color: Colors.black),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                onPressed: model.areAllPointsSpent()
                    ? null
                    : model.isTalentMaxedOutAt(talent.specId, talent.index)
                        ? null
                        : model.isTalentAvailableAt(talent.specId, talent.index)
                            ? () {
                                model.investPointAt(talent.specId, talent.index);
                                investedPoints = model.getInvestedPointsAt(talent.specId, talent.index);
                                setState(() {
                                  currentRankDesc = investedPoints == 0 ? "" : talent.ranks[investedPoints == 0 ? investedPoints : investedPoints - 1].desc;
                                  nextRankDesc = talent.ranks[investedPoints == talent.ranks.length ? investedPoints - 1 : investedPoints].desc;
                                });
                              }
                            : null,
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ],
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [..._buildTalentIconAndName(model, width, height)],
                  ),
                  const Divider(color: Colors.black),
                  SizedBox(height: SizeConfig.safeBlockVertical!),
                  if (investedPoints != 0) Text("Rank $investedPoints/${talent.ranks.length}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  if (investedPoints != 0)
                    Text(
                      currentRankDesc,
                      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 4),
                    ),
                  if (investedPoints != 0 && investedPoints != talent.ranks.length) const Divider(color: Colors.black),
                  if (investedPoints != talent.ranks.length) const Text("Next Rank:", style: TextStyle(fontWeight: FontWeight.bold)),
                  if (investedPoints != talent.ranks.length)
                    Text(
                      nextRankDesc,
                      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 4),
                    ),
                ],
              ),
            ),
          );
        });
      },
      viewModelBuilder: () => RanksDialogViewModel(),
    );
  }

  List<Widget> _buildTalentIconAndName(RanksDialogViewModel model, double width, double height) {
    return [
      Container(
        width: width / 2,
        height: height / 2,
        margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal! * 2),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(model.getTalentIcon(talent.icon)),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 3),
        ),
      ),
      Text(talent.name, style: const TextStyle(fontFamily: "LifeCraft")),
    ];
  }
}
