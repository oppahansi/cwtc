import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../exapnsions_viewmodel.dart';

class ExpansionsButtonView extends StatelessWidget {
  const ExpansionsButtonView({
    required this.expansionId,
    required this.expansionString,
    Key? key,
  }) : super(key: key);

  final int expansionId;
  final String expansionString;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpansionsViewModel>.nonReactive(
      builder: (context, model, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              model.setExpansion = expansionId;
              model.navigateToCharClassView();
            },
            child: Image.asset(model.getExpansionIcon(expansionString)),
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
          ),
        ),
      ),
      viewModelBuilder: () => ExpansionsViewModel(),
    );
  }
}
