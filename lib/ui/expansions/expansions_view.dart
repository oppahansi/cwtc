import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wow_talent_calculator/wow_talent_calculator.dart' as tc;

import '../../app/size_config.dart';
import '../../constants/constants.dart';
import '../widgets/app_title.dart';
import 'expansions_button/expansions_button_view.dart';
import 'exapnsions_viewmodel.dart';

class ExpansionsView extends StatefulWidget {
  const ExpansionsView({Key? key}) : super(key: key);

  @override
  State<ExpansionsView> createState() => _ExpansionsViewState();
}

class _ExpansionsViewState extends State<ExpansionsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ExpansionsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: Constants.getBgDecoration(model.getRngBgImageFilePath),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppTitle(),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ExpansionsButtonView(
                        expansionId: tc.Expansions.vanilla.index,
                        expansionString: tc.Expansions.vanilla.toShortString()),
                    ExpansionsButtonView(
                        expansionId: tc.Expansions.tbc.index, expansionString: tc.Expansions.tbc.toShortString()),
                    ExpansionsButtonView(
                        expansionId: tc.Expansions.wotlk.index, expansionString: tc.Expansions.wotlk.toShortString()),
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
