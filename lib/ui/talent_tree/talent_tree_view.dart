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
            child: Column(
              children: [
                Row(
                  children: [
                    model.getTalentForTreePosition(0, context),
                    model.getTalentForTreePosition(1, context),
                    model.getTalentForTreePosition(2, context),
                    model.getTalentForTreePosition(3, context),
                  ],
                ),
                Row(
                  children: [
                    model.getTalentForTreePosition(4, context),
                    model.getTalentForTreePosition(5, context),
                    model.getTalentForTreePosition(6, context),
                    model.getTalentForTreePosition(7, context),
                  ],
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
