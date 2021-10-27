import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/size_config.dart';
import '../../constants/constants.dart';
import 'char_class_button/char_class_button_view.dart';
import 'char_class_viewmodel.dart';

class CharClassView extends StatelessWidget {
  const CharClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<CharClassViewModel>.nonReactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black87,
            title: Text(
              model.getExpansionFull,
              style: const TextStyle(color: Colors.black87),
            ),
            backgroundColor: model.getExpansionColor,
          ),
          body: Container(
            decoration: Constants.getBgDecoration(model.getRngBgImageFilePath),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CharClassesButtonView(charClassId: 0),
                    CharClassesButtonView(charClassId: 1),
                    CharClassesButtonView(charClassId: 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CharClassesButtonView(charClassId: 3),
                    CharClassesButtonView(charClassId: 4),
                    CharClassesButtonView(charClassId: 5),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CharClassesButtonView(charClassId: 6),
                    CharClassesButtonView(charClassId: 7),
                    CharClassesButtonView(charClassId: 8),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    model.getExpansionId == 2 ? const CharClassesButtonView(charClassId: 9) : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CharClassViewModel(),
    );
  }
}
