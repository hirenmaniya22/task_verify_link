// hive_db.dart

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';

import '../models/links_record_model.dart';

class HiveDatabase {
  static String boxName = 'linkBox';
  static Future<void> initialize() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }
  static Future<Box> openBox() async {
    return Hive.openBox(boxName);
  }
  static Future<void> insertRecord(dynamic record) async {
    final Box box = await Hive.openBox(boxName);
    await box.add(record);
    await box.close();
  }

  static Future<void> updateRecord(int recordKey, dynamic updatedRecord) async {
    final Box box = await Hive.openBox(boxName);
    await box.putAt(recordKey, updatedRecord);
    await box.close();
  }

  static Future<void> deleteRecord(int recordKey) async {
    final Box box = await Hive.openBox(boxName);
    await box.delete(recordKey);
    await box.close();
  }
  static Future<List<LinksRecordModel>> getAllRecords() async {
    final Box box = await Hive.openBox(boxName);
    List<LinksRecordModel> records = [];

    box.values.forEach((element) {
      print("element ==> ${element}");
      records.add(LinksRecordModel.fromJson(element));
    });
    await box.close();
    return records;
  }

  // Give function to add data in model class
  static Future<void> addDataInModelClass() async {
    final Box box = await Hive.openBox(boxName);
    final record = LinksRecordModel(
      id: 1,
      imagePath: 'imagePath',
      title: 'title',
      url: 'url',
    );
    await box.add(record);
    await box.close();
  }

}
