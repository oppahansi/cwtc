import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'talent_spec/talent_spec_view.dart';
import 'talent_tree_viewmodel.dart';

class TalentTreeView extends StatelessWidget {
  const TalentTreeView({Key? key}) : super(key: key);

  Widget _buildTab(double imageWidth, double imageHeight, String imagePath) {
    return Tab(
      child: Container(
        height: imageWidth,
        width: imageHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imagePath),
          ),
          borderRadius: BorderRadius.all(Radius.circular(imageWidth)),
          border: Border.all(
            width: 3,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

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
                        _buildTab(talentImageWidth / 2, talentImageWidth / 2, model.getSpecIcon(0)),
                        _buildTab(talentImageWidth / 2, talentImageWidth / 2, model.getSpecIcon(1)),
                        _buildTab(talentImageWidth / 2, talentImageWidth / 2, model.getSpecIcon(2)),
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
