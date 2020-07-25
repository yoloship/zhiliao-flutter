import 'dart:convert';
import 'dart:io';
import 'package:zhiliao/model/bill_record_group.dart';
import 'package:zhiliao/model/bill_record_response.dart';
import 'package:zhiliao/model/budget_model.dart';
import 'package:zhiliao/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

var dbHelp = new Dbhelper();

class Dbhelper {
  // 单例
  Dbhelper._internal();

  static Dbhelper _singleton = new Dbhelper._internal();

  factory Dbhelper() => _singleton;

  Database _db;

  /// 账单表
  final _billTableName = 'BillRecord';

  /// 支出类别表
  final _initialExpenCategory = 'initialExpenCategory';

                                                                                                               /// 收入类别表
  final _initialIncomeCategory = 'initialIncomeCategory';

  /// 每月预算表
  final _budgetTableName = 'Budget';

  final _message = 'Message';

  /// 获取数据库
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  _initDb() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, 'ZhiLiao', 'ZhiLiao.db');
    debugPrint(path);
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  /// When creating the db, create the table type 1支出 2收入
  void _onCreate(Database db, int version) async {

    String message = """
    CREATE TABLE $_message(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT,
      isMe INTEGER,
      avatarUrl TEXT,
      myEmail TEXT,
      hisEmail TEXT,
      author TEXT
    )
    """;
    await db.execute(message);

    // 支出类别表
    String queryStringExpen = """
    CREATE TABLE $_initialExpenCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      image TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringExpen);

    // 收入类别表
    String queryStringIncome = """
    CREATE TABLE $_initialIncomeCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      image TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringIncome);



    // 初始化支出类别表数据
    rootBundle
        .loadString('assets/data/initialExpenCategory.json')
        .then((value) {
      List list = jsonDecode(value);
      List<CategoryItem> models =
          list.map((i) => CategoryItem.fromJson(i)).toList();
      models.forEach((item) async {
        await db.insert(_initialExpenCategory, item.toJson());
      });
    });

    // 初始化收入类别表数据
    rootBundle
        .loadString('assets/data/initialIncomeCategory.json')
        .then((value) {
      List list = jsonDecode(value);
      List<CategoryItem> models =
          list.map((i) => CategoryItem.fromJson(i)).toList();
      models.forEach((item) async {
        await db.insert(_initialIncomeCategory, item.toJson());
      });
    });

  }
  Future<List> getInitialExpenCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_initialExpenCategory ORDER BY sort ASC');
    return result.toList();
  }

  /// 获取记账收入类别列表
  Future<List> getInitialIncomeCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_initialIncomeCategory ORDER BY sort ASC');
    return result.toList();
  }

  Future<int> saveMessage(map) async{
    var dbClient = await db;
    int result = await dbClient.insert('Message', map);
    return result;
  }

}
