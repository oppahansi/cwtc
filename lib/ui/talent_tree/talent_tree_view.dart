import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'talent/talent_view.dart';
import 'talent_tree_viewmodel.dart';

class TalentTreeView extends StatelessWidget {
  const TalentTreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: List.generate(model.getTreeLength, (index) {
                Widget widget = SizedBox.shrink();

                if (model.showTalentOnIndex) {
                  var talent = model.getTalentForIndex(index);
                  model.setTalentIndex(model.getTalentIndex + 1);

                  widget = TalentView();
                }

                return widget;
              }),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
