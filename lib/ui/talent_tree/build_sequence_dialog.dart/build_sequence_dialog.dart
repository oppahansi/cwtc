import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/sequence_point.dart' as app_model;
import 'build_sequence_viewmodel.dart';
import 'sequence_point_card.dart';

class BuildSequenceDialogView extends StatelessWidget {
  const BuildSequenceDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuildSequenceViewModel>.reactive(
      builder: (context, model, child) {
        List<app_model.SequencePoint> buildSequence = model.getBuildSequence();

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: model.getExpansionColor,
            actionsOverflowButtonSpacing: 10,
            content: buildSequence.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          buildSequence.length,
                          (index) {
                            return SequencePointCard(sequencePoint: buildSequence[index]);
                          },
                        ),
                      ],
                    ),
                  )
                : const Text("No points spent yet.", style: TextStyle(color: Colors.black)),
          ),
        );
      },
      viewModelBuilder: () => BuildSequenceViewModel(),
    );
  }
}
