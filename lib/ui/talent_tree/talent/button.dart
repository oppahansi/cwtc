import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/talent.dart';
import 'button_viewmodel.dart';
import 'image.dart';
import '../ranks_dialog/ranks_dialog.dart';

class TalentButton extends StatelessWidget {
  final Talent talent;

  const TalentButton({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TalentButtonViewModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        onTap: () => model.showToolTips ? _showMyDialog(context, model, talent) : model.investPointAt(talent.specId, talent.index),
        onDoubleTap: () => model.showToolTips ? _showMyDialog(context, model, talent) : model.removePointAt(talent.specId, talent.index),
        child: TalentImage(talent: talent),
      ),
      viewModelBuilder: () => TalentButtonViewModel(),
    );
  }

  Future<void> _showMyDialog(BuildContext context, TalentButtonViewModel model, Talent talent) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => RanksDialog(talent: talent),
    );
  }
}
