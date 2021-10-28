import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_models/char_class.dart';
import '../data_models/dependency.dart';
import '../data_models/rank.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

class DBService {
  static final Map<String, Database> _dbs = {};

  Future<Database?> getDb(String expansion) async {
    if (_dbs.containsKey(expansion)) {
      return _dbs[expansion];
    }
    var db = await initDb(expansion);

    _dbs.putIfAbsent(expansion, () => db);
    return db;
  }

  Future<Database> initDb(String expansion) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "$expansion.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets/data", "$expansion.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<CharClass>> getCharClasses(String expansion) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("classes");
    List<CharClass> charClasses = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      CharClass charClass = CharClass.fromMap(rsultRow);
      charClasses.add(charClass);
    }

    return charClasses;
  }

  Future<List<Spec>> getSpecsByExpansion(String expansion) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("specs");
    List<Spec> specs = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Spec charClass = Spec.fromMap(rsultRow);
      specs.add(charClass);
    }

    return specs;
  }

  Future<List<Spec>> getSpecs(String expansion, int charClassId) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("specs", where: "classId = ?", whereArgs: [charClassId]);
    List<Spec> specs = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Spec charClass = Spec.fromMap(rsultRow);
      specs.add(charClass);
    }

    return specs;
  }

  Future<List<Talent>> getTalentsByExpansion(String expansion) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("talents");
    List<Talent> talents = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Talent talent = Talent.fromMap(rsultRow);
      talents.add(talent);
    }

    return talents;
  }

  Future<List<Talent>> getTalentsByExpansionAndClass(String expansion, int charClass) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("talents", where: "classId = ?", whereArgs: [charClass], orderBy: "rowid");
    List<Talent> talents = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Talent talent = Talent.fromMap(rsultRow);
      talents.add(talent);
    }

    return talents;
  }

  Future<List<Talent>> getTalentsByExpansionAndClassAndSpec(String expansion, int charClassId, int specId) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("talents", where: "classId = ? AND specId = ?", whereArgs: [charClassId, specId], orderBy: "rowid");
    List<Talent> talents = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Talent talent = Talent.fromMap(rsultRow);
      talents.add(talent);
    }

    return talents;
  }

  Future<List<Talent>> getTalents(String expansion, int charClassId, int specId) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("talents", where: "classId = ? AND specId = ?", whereArgs: [charClassId, specId], orderBy: "rowid");
    List<Talent> talents = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Talent talent = Talent.fromMap(rsultRow);
      talents.add(talent);
    }

    return talents;
  }

  Future<List<Rank>> getRanksByExpansion(String expansion) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("ranks");
    List<Rank> ranks = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Rank rank = Rank.fromMap(rsultRow);
      ranks.add(rank);
    }

    return ranks;
  }

  Future<List<Rank>> getRanks(String expansion, List<int> talentIds) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("ranks", where: "talentId IN (${talentIds.join(', ')})");
    List<Rank> ranks = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Rank rank = Rank.fromMap(rsultRow);
      ranks.add(rank);
    }

    return ranks;
  }

  Future<List<Dependency>> getDependenciesByExpansion(String expansion) async {
    var db = await getDb(expansion);
    var dbResult = await db!.query("dependencies");
    List<Dependency> dependencies = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      Dependency dependency = Dependency.fromMap(rsultRow);
      dependencies.add(dependency);
    }

    return dependencies;
  }
}
