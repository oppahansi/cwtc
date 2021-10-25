import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'talent_spec/talent_spec_view.dart';
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
                foregroundColor: Colors.black87,
                title: Text(
                  model.getClassName,
                  style: const TextStyle(color: Colors.black87),
                ),
                backgroundColor: model.getClassColor,
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 40),
                  child: Container(
                    color: model.getExpansionColor,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.black,
                      indicatorPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                      tabs: [
                        Tab(
                          child: Container(
                            height: talentImageWidth / 2,
                            width: talentImageWidth / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(model.getSpecIcon(0)),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(talentImageWidth / 2)),
                              border: Border.all(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: talentImageWidth / 2,
                            width: talentImageWidth / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(model.getSpecIcon(1)),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(talentImageWidth / 2)),
                              border: Border.all(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: talentImageWidth / 2,
                            width: talentImageWidth / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(model.getSpecIcon(2)),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(talentImageWidth / 2)),
                              border: Border.all(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
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
