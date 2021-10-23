import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'talent_tree_viewmodel.dart';

class TalentTreeView extends StatelessWidget {
  const TalentTreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double length = SizeConfig.safeBlockHorizontal! * 20;
    return ViewModelBuilder<TalentTreeViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(model.getClassName),
            backgroundColor: model.getClassColor,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.getBGImage),
                fit: BoxFit.fill,
              ),
            ),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 0.0,
              children: [
                ...List.generate(model.getTreeLength, (index) {
                  return model.getTalentForTreePosition(index, length);
                }),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
