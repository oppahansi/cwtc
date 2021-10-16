import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../data_models/talent.dart';
import 'talent_viewmodel.dart';

class TalentView extends StatelessWidget {
  final Talent talent;

  const TalentView({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TalentViewModel>.reactive(
      builder: (context, model, child) => Stack(
        clipBehavior: Clip.none,
        children: [
          TextButton(
            onPressed: () {
              model.isTalentDisabled() ? null : model.incrementTalentPoints();
            },
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(model.getIcon(talent.icon)),
                  colorFilter: model.isTalentDisabled() ? const ColorFilter.mode(Colors.grey, BlendMode.saturation) : null,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 3,
                  color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  width: 2,
                  color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400,
                ),
              ),
              child: Text(
                model.getTalentPoints.toString(),
                style: TextStyle(color: model.isTalentDisabled() ? Colors.grey : Colors.green.shade400),
              ),
            ),
          ),
          AlignPositioned(
            child: Image.asset(
              "assets/images/arrows/arrowrightshort.png",
              scale: 1.2,
            ),
            alignment: Alignment.centerRight,
            moveByChildWidth: 0.6,
          ),
        ],
      ),
      viewModelBuilder: () => TalentViewModel(talent),
    );
  }
}
