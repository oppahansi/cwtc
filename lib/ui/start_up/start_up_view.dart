import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:rainbow_color/rainbow_color.dart';

import '../widgets/app_title.dart';
import 'start_up_viewmodel.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..repeat();
    _colorAnim = bgColor.animate(_controller);
  }

  Animatable<Color> bgColor = RainbowColorTween([
    Colors.orange,
    Colors.green,
    Colors.blue,
  ]);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.getRngBgImageFilePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const AppTitle(),
                const SizedBox(height: 25),
                SizedBox(width: 200, child: Image.asset(model.getAppIcon)),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(valueColor: _colorAnim),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
