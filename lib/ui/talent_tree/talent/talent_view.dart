import 'package:classic_wow_talent_calculator_stacked/data_models/talent.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'talent_viewmodel.dart';

class TalentView extends StatelessWidget {
  final Talent talent;

  const TalentView({required this.talent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TalentViewModel>.reactive(
      builder: (context, model, child) => Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(model.getIcon(talent.icon)),
                //colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 3,
                color: Colors.green.shade400,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  width: 2,
                  color: Colors.green,
                ),
              ),
              child: Text(
                model.getTalentPoints.toString(),
                style: TextStyle(color: Colors.green),
              ),
            ),
          )
        ],
      ),
      viewModelBuilder: () => TalentViewModel(),
    );
  }
}
