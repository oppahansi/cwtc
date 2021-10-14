import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data_models/char_class.dart';

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
}
