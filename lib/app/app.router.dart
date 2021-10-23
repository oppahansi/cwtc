// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/char_classes/char_class_view.dart';
import '../ui/expansions/expansions_view.dart';
import '../ui/start_up/start_up_view.dart';
import '../ui/talent_tree/talent_tree_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String expansionsView = '/expansions-view';
  static const String charClassView = '/char-class-view';
  static const String talentTreeView = '/talent-tree-view';
  static const all = <String>{
    startUpView,
    expansionsView,
    charClassView,
    talentTreeView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.expansionsView, page: ExpansionsView),
    RouteDef(Routes.charClassView, page: CharClassView),
    RouteDef(Routes.talentTreeView, page: TalentTreeView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    ExpansionsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ExpansionsView(),
        settings: data,
      );
    },
    CharClassView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CharClassView(),
        settings: data,
      );
    },
    TalentTreeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TalentTreeView(),
        settings: data,
      );
    },
  };
}
