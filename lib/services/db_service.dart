import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_models/char_build.dart';
import '../data_models/char_class.dart';
import '../data_models/dependency.dart';
import '../data_models/rank.dart';
import '../data_models/sequence_point.dart';
import '../data_models/settings.dart';
import '../data_models/spec.dart';
import '../data_models/talent.dart';

@lazySingleton
class DBService {
  static const int dbVersion = 1;
  static final Map<String, Database> _dbs = {};

  Future<Database?> getDb(String name) async {
    if (_dbs.containsKey(name)) {
      return _dbs[name];
    }
    var db = await initDb(name);

    _dbs.putIfAbsent(name, () => db);
    return db;
  }

  Future<Database> initDb(String name) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "$name.db");

    var exists = await databaseExists(path);

    if (!exists) {
      await _copyDBToLocalStorage(path, name);
    }

    var db = await openDatabase(path, readOnly: name == "wtc" ? false : true);

    if (name != "wtc" && await db.getVersion() < dbVersion) {
      db.close();
      await deleteDatabase(path);
      await _copyDBToLocalStorage(path, name);
      db = await openDatabase(path);
      db.setVersion(dbVersion);
    }

    return db;
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

  Future<Settings> getSettings() async {
    var db = await getDb("wtc");
    var dbResult = await db!.query("settings");
    return Settings.fromMap(dbResult.first);
  }

  Future<List<CharBuild>> getCharBuilds(int expansion) async {
    var db = await getDb("wtc");
    var dbResult = await db!.query("builds", where: "expansionId = ?", whereArgs: [expansion]);
    List<CharBuild> charBuilds = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      CharBuild charBuild = CharBuild.fromMap(rsultRow);
      charBuilds.add(charBuild);
    }

    return charBuilds;
  }

  Future<List<SequencePoint>> getBuildSequences(int expansion) async {
    var db = await getDb("wtc");
    var dbResult = await db!.query("buildSequences", where: "expansionId = ?", whereArgs: [expansion]);
    List<SequencePoint> buildSequences = List.empty(growable: true);

    for (var rsultRow in dbResult) {
      SequencePoint buildSequence = SequencePoint.fromMap(rsultRow);
      buildSequences.add(buildSequence);
    }

    return buildSequences;
  }

  Future<void> saveBuild(CharBuild charBuild, List<SequencePoint> buildSequence) async {
    var db = await getDb("wtc");
    await db!.insert(
      "builds",
      {
        "expansionId": charBuild.expansionId,
        "charClassId": charBuild.charClassId,
        "buildId": charBuild.buildId,
        "title": charBuild.title,
        "summary": charBuild.summary,
        "specState0": charBuild.specState0,
        "specState1": charBuild.specState1,
        "specState2": charBuild.specState2,
      },
    );

    await saveBuildSequence(buildSequence);
  }

  Future<void> updateBuild(CharBuild charBuild, List<SequencePoint> buildSequence) async {
    var db = await getDb("wtc");
    await db!.update("builds", charBuild.toMap(),
        where: "expansionId = ? AND charClassId = ? AND buildId = ?", whereArgs: [charBuild.expansionId, charBuild.charClassId, charBuild.buildId]);

    await deleteBuildSequence(charBuild);
    await saveBuildSequence(buildSequence);
  }

  Future<void> deleteCharBuild(CharBuild charBuild) async {
    var db = await getDb("wtc");
    await db!.delete(
      "builds",
      where: "expansionId = ? AND charClassId = ? AND buildId = ?",
      whereArgs: [charBuild.expansionId, charBuild.charClassId, charBuild.buildId],
    );
    await deleteBuildSequence(charBuild);
  }

  Future<void> saveShowTooltips(int showTooltips) async {
    var db = await getDb("wtc");
    await db!.update("settings", {"showTooltips": showTooltips});
  }

  Future<void> saveBuildSequence(List<SequencePoint> buildSequence) async {
    var db = await getDb("wtc");
    var batch = db!.batch();

    for (var sequencePoint in buildSequence) {
      batch.insert(
        "buildSequences",
        {
          "expansionId": sequencePoint.expansionId,
          "charClassId": sequencePoint.charClassId,
          "specId": sequencePoint.specId,
          "talentIndex": sequencePoint.talentIndex,
          "buildId": sequencePoint.buildId,
          "sequencePoint": sequencePoint.sequencePoint,
          "talentIcon": sequencePoint.talentIcon,
          "rank": sequencePoint.rank,
        },
      );
    }

    batch.commit(noResult: true);
  }

  Future<void> deleteBuildSequence(CharBuild charBuild) async {
    var db = await getDb("wtc");
    await db!.delete(
      "buildSequences",
      where: "expansionId = ? AND charClassId = ? AND buildId = ?",
      whereArgs: [charBuild.expansionId, charBuild.charClassId, charBuild.buildId],
    );
  }

  Future<void> _copyDBToLocalStorage(String path, String name) async {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets/data", "$name.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(path).writeAsBytes(bytes, flush: true);
  }
}
