import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data_models/char_build.dart';
import 'char_build_card.dart';
import 'char_builds_viewmodel.dart';

class CharBuildsView extends StatelessWidget {
  const CharBuildsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CharBuildsViewModel>.reactive(
      builder: (context, model, child) {
        List<CharBuild> charBuilds = model.getCharBuilds;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: model.getExpansionColor,
            actionsOverflowButtonSpacing: 10,
            content: charBuilds.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          charBuilds.length,
                          (index) {
                            return GestureDetector(
                              onTap: () => model.loadCharBuild(charBuilds[index]),
                              child: Dismissible(
                                onDismissed: (DismissDirection direction) {
                                  if (direction == DismissDirection.endToStart) {
                                    setState(
                                      () {
                                        model.deleteCharBuild(charBuilds[index]);
                                        charBuilds.removeAt(index);
                                      },
                                    );
                                  }
                                },
                                confirmDismiss: (DismissDirection direction) async {
                                  return await showDialog(
                                    barrierDismissible: true,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      if (direction == DismissDirection.endToStart) {
                                        return AlertDialog(
                                          title: const Text("Delete Confirmation"),
                                          content: const Text("Are you sure you want to delete this build?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                                              onPressed: () {
                                                model.deleteCharBuild(charBuilds[index]);
                                                SnackBar snackBar = SnackBar(
                                                  backgroundColor: model.getExpansionColor,
                                                  content: const Text(
                                                    'Build deleted.',
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                Navigator.pop(context, true);
                                              },
                                              child: const Text("Delete", style: TextStyle(color: Colors.black)),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                                              onPressed: () => Navigator.pop(context, false),
                                              child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return AlertDialog(
                                          title: const Text("Open online confirmation"),
                                          content: const Text("Are you sure you want to open this build online?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                                              onPressed: () {
                                                CharBuild charBuild = charBuilds[index];
                                                String link = model.getShareableLink(charBuild);
                                                _launchURL(context, link);
                                                Navigator.pop(context, false);
                                              },
                                              child: const Text("Yes", style: TextStyle(color: Colors.black)),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: model.getExpansionColor),
                                              onPressed: () => Navigator.pop(context, false),
                                              child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  );
                                },
                                background: Container(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.web, color: Colors.white),
                                        Text('Open online', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(Icons.delete, color: Colors.white),
                                        Text('Delete', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                key: UniqueKey(),
                                child: CharBuildCard(
                                  charBuild: charBuilds[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : const Text("No saved builds found.", style: TextStyle(color: Colors.black)),
          ),
        );
      },
      viewModelBuilder: () => CharBuildsViewModel(),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Could not open build online.',
          style: TextStyle(color: Colors.black),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
