import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart';

import '../../constants/constants.dart';
import '../../extensions/extensions.dart';
import '../widgets/app_title.dart';
import 'exapnsions_viewmodel.dart';
import 'expansions_button/expansions_button_view.dart';

class ExpansionsView extends StatelessWidget {
  const ExpansionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpansionsViewModel>.nonReactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: Constants.getBgDecoration(model.getRngBgImage),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppTitle(),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ExpansionsButtonView(
                      expansionId: Expansions.vanilla.index,
                      expansionString: Expansions.vanilla.toShortString(),
                    ),
                    ExpansionsButtonView(
                      expansionId: Expansions.tbc.index,
                      expansionString: Expansions.tbc.toShortString(),
                    ),
                    ExpansionsButtonView(
                      expansionId: Expansions.wotlk.index,
                      expansionString: Expansions.wotlk.toShortString(),
                    ),
                  ],
                  // TODO add load button for loading saved talent build
                  // TODO add settings button to configure app
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExpansionsViewModel(),
    );
  }
}
