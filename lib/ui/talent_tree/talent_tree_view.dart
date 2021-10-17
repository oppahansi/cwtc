import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import 'talent/talent_view.dart';
import 'talent_tree_viewmodel.dart';

class TalentTreeView extends StatelessWidget {
  const TalentTreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            child: Stack(
              children: [
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: List.generate(model.getTreeLength, (index) {
                    Widget widget = const SizedBox.shrink();

                    if (model.showTalentOnIndex(index)) {
                      var talent = model.getCurrentTalent;
                      widget = TalentView(talent: talent);
                    }

                    return widget;
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => TalentTreeViewModel(),
    );
  }
}
