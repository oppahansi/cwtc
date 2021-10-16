import 'package:classic_wow_talent_calculator_stacked/app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../constants/constants.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import 'exapnsions_viewmodel.dart';

class ExpansionsView extends StatelessWidget {
  const ExpansionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ExpansionsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.getRngBgImageFilePath),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Classic WoW\nTalent Calculator",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal! * 10,
                    fontFamily: "LifeCraft",
                    shadows: const [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.white),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.white),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.white),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            model.setExpansion(Expansions.vanilla.index);
                            locator<NavigationService>().navigateTo(Routes.charClassView);
                          },
                          child: Image.asset(model.getExpansionIcon(Expansions.vanilla.toShortString())),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            model.setExpansion(Expansions.tbc.index);
                            locator<NavigationService>().navigateTo(Routes.charClassView);
                          },
                          child: Image.asset(model.getExpansionIcon(Expansions.tbc.toShortString())),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            model.setExpansion(Expansions.wotlk.index);
                            locator<NavigationService>().navigateTo(Routes.charClassView);
                          },
                          child: Image.asset(model.getExpansionIcon(Expansions.wotlk.toShortString())),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // TODO add load button for loading saved talent build
                  // TODO add settings button to configure app
                ),
                const SizedBox(height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExpansionsViewModel(),
    );
  }
}
