import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'talent_viewmodel.dart';

class TalentView extends StatelessWidget {
  const TalentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TalentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => TalentViewModel(),
    );
  }
}
