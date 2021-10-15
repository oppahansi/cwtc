import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import 'char_class_viewmodel.dart';

class CharClassView extends StatelessWidget {
  const CharClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CharClassViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(model.getExpansionFull),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.getRngBgImageFilePath),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: model.isBusy
                    ? [const CircularProgressIndicator()]
                    : List.generate(model.data!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: () {
                              model.setClass(model.data![index].id);
                              locator<NavigationService>().navigateTo(Routes.talentTreeView);
                            },
                            child: Image.asset("assets/images/icons/${model.data![index].icon}.png"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                          ),
                        );
                      }),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CharClassViewModel(),
    );
  }
}
