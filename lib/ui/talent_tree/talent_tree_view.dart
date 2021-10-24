import 'package:classic_wow_talent_calculator_stacked/constants/constants.dart';
import 'package:classic_wow_talent_calculator_stacked/ui/talent_tree/talent_spec/talent_spec_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'talent_tree_viewmodel.dart';

class TalentTreeView extends StatelessWidget {
  const TalentTreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double talentImageWidth = SizeConfig.safeBlockHorizontal! * 20;
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) => DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                title: Text(model.getClassName),
                backgroundColor: model.getClassColor,
                bottom: TabBar(
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: model.getClassColor, width: 8.0),
                      insets: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                    ),
                    tabs: [
                      Tab(
                        text: model.getSpecName(0),
                      ),
                      Tab(
                        text: model.getSpecName(1),
                      ),
                      Tab(
                        text: model.getSpecName(2),
                      ),
                    ])),
            body: TabBarView(children: [
              TalentSpecView(specId: 0, talentImageWidth: talentImageWidth),
              TalentSpecView(specId: 1, talentImageWidth: talentImageWidth),
              TalentSpecView(specId: 2, talentImageWidth: talentImageWidth),
            ]),
          ),
        ),
      ),
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
