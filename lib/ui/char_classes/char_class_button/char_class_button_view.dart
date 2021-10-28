import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../char_class_viewmodel.dart';

class CharClassesButtonView extends StatelessWidget {
  const CharClassesButtonView({
    required this.charClassId,
    Key? key,
  }) : super(key: key);

  final int charClassId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CharClassViewModel>.nonReactive(
      builder: (context, model, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              model.setCharClassId(charClassId);
              model.initTalentCalculator();
              model.navigateToTalentTreeView();
            },
            child: SizedBox(
              height: SizeConfig.safeBlockHorizontal! * 20,
              child: Image.asset(model.getCharClassIcon(charClassId), fit: BoxFit.cover),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CharClassViewModel(),
    );
  }
}
