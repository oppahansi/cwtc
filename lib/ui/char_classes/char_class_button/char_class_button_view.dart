import 'package:classic_wow_talent_calculator_stacked/app/app.locator.dart';
import 'package:classic_wow_talent_calculator_stacked/app/app.router.dart';
import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/char_classes/char_class_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CharClassesButtonView extends StatelessWidget {
  final int charClassId;

  const CharClassesButtonView({required this.charClassId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CharClassViewModel>.reactive(
      builder: (context, model, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              model.setCharClassId(charClassId);
              locator<NavigationService>().navigateTo(Routes.talentTreeView);
            },
            child: SizedBox(
              height: SizeConfig.safeBlockHorizontal! * 20,
              child: Image.asset(model.getCharClassIconForId(charClassId), fit: BoxFit.cover),
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
