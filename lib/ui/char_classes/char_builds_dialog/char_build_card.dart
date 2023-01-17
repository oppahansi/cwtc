import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/char_build.dart';
import 'char_builds_viewmodel.dart';

class CharBuildCard extends StatelessWidget {
  final CharBuild charBuild;

  const CharBuildCard({required this.charBuild, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CharBuildsViewModel>.nonReactive(
      builder: (context, model, child) => Card(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(model.getCharClassIcon(charBuild.charClassId))),
              title: Text(charBuild.title),
              subtitle: Text(charBuild.summary),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => CharBuildsViewModel(),
    );
  }
}
