import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:cwtc/ui/talent_tree/update_char_build_dialog/update_char_build_dialog_viewmodel.dart';

class UpdateCharBuildDialogView extends StatelessWidget {
  const UpdateCharBuildDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return ViewModelBuilder<UpdateCharBuildDialogViewModel>.reactive(
      builder: (context, model, child) => StatefulBuilder(
        builder: (context, setState) {
          textFieldController.text = model.getCharBuildTitle;

          return AlertDialog(
            backgroundColor: model.getCharClassColor,
            actionsOverflowButtonSpacing: 10,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                onPressed: () {
                  model.updateCharBuild(textFieldController.text);
                  SnackBar snackBar = SnackBar(
                    backgroundColor: model.getCharClassColor,
                    content: const Text(
                      'Build updated.',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context, true);
                },
                child: const Text("Update", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
            ],
            content: TextField(
              controller: textFieldController,
              autofocus: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter build title',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
      viewModelBuilder: () => UpdateCharBuildDialogViewModel(),
    );
  }
}
