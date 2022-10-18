import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Student.dart';
import '../model/user.dart';

class DatabaseHelper {
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;

  // DatabaseHelper._privateConstructor();
  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper.internal();
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;



  Future<Database?> get database async {
    if (_database != null) return _database;
    String path = join(await getDatabasesPath(), _databaseName);
    return _database = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }


  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(Student.createTable);
    await db.execute(User.createTable);
  }

  Future<int> truncateTable(String tableName) async {
    var dbClient = await database;
    int result = await dbClient!.delete(tableName);
    //if ( result > 0) print('$tableName is Truncated');
    return result;
  }

  Future<int> saveMasterTable(var mapList, String table) async {
    var db = await database;
    int result = 0;
    for (var value in mapList) {
      result = await db!.insert(table, value);
    }
    return result;
  }

  //insert todo
  Future<int?> insert(Map<String, dynamic> list) async {
    Database? db = await database;
    var res = await db?.insert("student", list);
    return res;
  }

  //insert user
  Future<int?> insertUser(Map<String, dynamic> list) async {
    Database? db = await database;
    var res = await db?.insert("user", list);
    return res;
  }

  //all todo list
  Future<List<Student>> queryAllRows() async {
    var db = await database;
    List<Map<String, dynamic>> resultMap = await db!.query("student", orderBy: "id DESC");
    return resultMap.map((f) => Student.fromMap(f)).toList();
  }

  //all user list
  Future<List<User>> queryAllRowsData() async {
    var db = await database;
    List<Map<String, dynamic>> resultMap =
        await db!.query("user", orderBy: "id DESC");
    return resultMap.map((f) => User.fromMap(f)).toList();
  }

  //delete todo
  Future<int?> delete(int id) async {
    Database? db = await database;
    return await db?.delete("student", where: 'id = ?', whereArgs: [id]);
  }

  //clear todo table
  Future<List<Map<String, Object?>>?> clearTable(String id) async {
    Database? db = await database;
    return await db?.rawQuery("delete form student where id = " + id);
  }

  //clear user table
  Future<List<Map<String, Object?>>?> clearUserTable(String id) async {
    Database? db = await database;
    return await db?.rawQuery("delete form user where id = " + id);
  }
}
