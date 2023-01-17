import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/size_config.dart';
import '../../../data_models/talent.dart';
import 'image_viewmodel.dart';

class TalentImage extends StatelessWidget {
  final Talent talent;

  const TalentImage({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.safeBlockHorizontal! * 17.5;
    double height = SizeConfig.safeBlockHorizontal! * 17.5;

    return ViewModelBuilder<TalentImageViewModel>.reactive(
      builder: (context, model, child) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(model.getTalentIcon(talent.icon)),
            colorFilter: model.getColorFilter(talent),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 3,
            color: model.getStateColor(talent),
          ),
        ),
      ),
      viewModelBuilder: () => TalentImageViewModel(),
    );
  }
}
