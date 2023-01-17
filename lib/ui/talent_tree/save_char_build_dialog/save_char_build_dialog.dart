import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'save_char_build_dialog_viewmodel.dart';

class SaveCharBuildDialogView extends StatelessWidget {
  const SaveCharBuildDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return ViewModelBuilder<SaveCharBuildDialogViewModel>.reactive(
      builder: (context, model, child) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: model.getCharClassColor,
            actionsOverflowButtonSpacing: 10,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                onPressed: () {
                  model.saveCharBuild(textFieldController.text);
                  SnackBar snackBar = SnackBar(
                    backgroundColor: model.getCharClassColor,
                    content: const Text(
                      'Build saved.',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context, true);
                },
                child: const Text("Save", style: TextStyle(color: Colors.black)),
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
      viewModelBuilder: () => SaveCharBuildDialogViewModel(),
    );
  }
}
