import 'package:flutter/material.dart';

import '../../app/size_config.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      "Legacy WoW\nTalent Calculator",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: SizeConfig.safeBlockHorizontal! * 10,
        fontFamily: "LifeCraft",
        shadows: const [
          Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
          Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
          Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
          Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
        ],
      ),
    );
  }
}
