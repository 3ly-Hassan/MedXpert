import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'models/notification_models/local_notofocation_model.dart';

class DBHelper {
  static const String databaseName = 'grad.db';
  static const String notificationTableName = 'notifications';
  static const String sharedPrefsTableName = 'sharedpref';

  static Future createDatabase() async {
    final databasePath = await getDatabasesPath();
    var database = openDatabase(
      path.join(databasePath, databaseName),
      onCreate: (db, version) {
        //ToDo: note =>
        //what inside onCreate methode called only once, so you can insert initial records as you need !
        final createdTable = _crateTables(db);
        _insertNotificationId(db);
        return createdTable;
      },
      version: 1,
    );

    print('DB open "creation" finished successfully');
    return database;
  }

  static _crateTables(Database db) {
    // Run the CREATE TABLE statement on the database.
    db.execute(
      'CREATE TABLE $notificationTableName (notificationId TEXT, drugUniqueId TEXT, patientName TEXT, drugName TEXT, date TEXT, time TEXT)',
    );
    db.execute(
      'CREATE TABLE $sharedPrefsTableName (key TEXT, value TEXT)',
    );
  }

  static _insertNotificationId(Database db) {
    db.insert(
      sharedPrefsTableName,
      {'key': 'notificationId', 'value': '1'},
    );
  }

  static Future<void> insertValue(table, data) async {
    final Database db = await DBHelper.createDatabase();
    await db.insert(
      table,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('DB insertion finished successfully');
  }

  static Future<bool> isCreatedPreviously(
      String drugUniqueId, String date, String time, String drugName) async {
    final Database db = await DBHelper.createDatabase();

    final List list = await db.query(
      notificationTableName,
      where: 'drugUniqueId = ? and date = ? and time = ? and drugName = ?',
      whereArgs: ['$drugUniqueId', '$date', '$time', '$drugName'],
    );
    if (list.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<List> getAllNotification() async {
    final Database db = await DBHelper.createDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
      notificationTableName,
    );

    return List.generate(
      maps.length,
      (i) => LocalNotificationModel.fromJson(maps[i]),
    );
  }

  static Future<void> deleteNotificationById(
      table, String notificationId) async {
    final Database db = await DBHelper.createDatabase();
    await db.delete(
      table,
      where: 'notificationId = ?',
      whereArgs: ['$notificationId'],
    );
    print('DB Deleting finished successfully');
  }

  static Future<void> deleteNotification2(
      LocalNotificationModel localNotificationModel) async {
    final Database db = await DBHelper.createDatabase();
    await db.delete(
      notificationTableName,
      where:
          'drugUniqueId = ? and date = ? and time = ? and drugName = ? and patientName = ?',
      whereArgs: [
        '${localNotificationModel.drugUniqueId}',
        '${localNotificationModel.date}',
        '${localNotificationModel.time}',
        '${localNotificationModel.drugName}',
        '${localNotificationModel.username}'
      ],
    );
    print('DB Deleting finished successfully');
  }

  static Future<List<LocalNotificationModel>> getNotificationsByDrugUniqueId(
      String drugUniqueId) async {
    final Database db = await DBHelper.createDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
      notificationTableName,
      where: 'drugUniqueId = ?',
      whereArgs: ['$drugUniqueId'],
    );

    return List.generate(
      maps.length,
      (i) => LocalNotificationModel.fromJson(maps[i]),
    );
  }

//--------------------* Shared preferences *---------------------------------------------

  // we have a table called sharedpref with two columns called key & value
  // but we also can use shared preferences plugin

  static Future<void> insertSharedValue(
      String sharedKey, String sharedValue) async {
    final Database db = await DBHelper.createDatabase();

    await db.insert(
      sharedPrefsTableName,
      {
        'key': sharedKey,
        'value': sharedValue,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateSharedValue(
      String sharedKey, String sharedValue) async {
    final Database db = await DBHelper.createDatabase();

    await db.update(
      sharedPrefsTableName,
      {
        'key': sharedKey,
        'value': sharedValue,
      },
    );
  }

  static Future<String> getSharedValue(String sharedKey) async {
    final Database db = await DBHelper.createDatabase();

    final List<Map<String, dynamic>> maps = await db.query(
      DBHelper.sharedPrefsTableName,
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['$sharedKey'],
    );
    //print('*******${maps[0]['value']}');

    return maps[0]['value'];

    /* or.....it also works !!!

    final List<Map<String, dynamic>> maps = await db.query(DBHelper.sharedPrefsTableName);

    return List.generate(
      maps.length,
      (i) => SharedPrefModel.fromMap(maps[i]),
    )[0]
        .value; */
  }

  //we can use shared preferences also to handle generation of integer id
  // but we have already used database for such thing, so we will not delete
  // that code and convert it to shared preferences !
  static Future<int> getNotificationId() async {
    //get the current id
    final String notificationId =
        await DBHelper.getSharedValue('notificationId');
    //convert id to int
    int intId = int.parse(notificationId);
    //add one to its value
    final int newIntId = intId + 1;
    //update its value in the database
    await DBHelper.updateSharedValue('notificationId', '$newIntId');
    return newIntId;
    //
  }
}
