import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:simple_todo_list/Models/todo_model.dart';
import 'package:simple_todo_list/Models/user_model.dart';

class DatabaseHelper {
  // Nama dan versi database
  static const _databaseName = 'db_todoapp_simple2.db';
  static const _databaseVersion = 1;

  // Nama tabel dan nama kolom untuk Todo
  static const tableTodo = 'Todo';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnSubtitle = 'subtitle';
  static const columnDescription = 'description';
  static const columnPriority = 'priority';
  static const columnDate = 'date';
  static const columnDate2 = 'date2';
  static const columnTime = 'time';
  static const columnIsCompleted = 'isCompleted';

  // Nama tabel dan nama kolom untuk Users
  static const tableUsers = 'Users';
  static const columnUserId = 'usrId';
  static const columnUserName = 'usrName';
  static const columnUserPassword = 'usrPassword';

  DatabaseHelper();

  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY, $columnTitle TEXT NOT NULL, $columnSubtitle TEXT NOT NULL, $columnDescription TEXT NOT NULL, $columnPriority INTEGER NOT NULL, $columnDate TEXT NOT NULL, $columnDate2 TEXT NOT NULL, $columnTime TEXT NOT NULL, $columnIsCompleted INTEGER NOT NULL)");

    await db.execute(
        "CREATE TABLE $tableUsers($columnUserId INTEGER PRIMARY KEY, $columnUserName TEXT UNIQUE, $columnUserPassword TEXT)");
  }

  Future<Todo> insert(Todo todo) async {
    final db = await database;
    await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Todo>> getTodo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableTodo);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        subtitle: maps[i][columnSubtitle],
        description: maps[i][columnDescription],
        priority: maps[i][columnPriority],
        date: maps[i][columnDate],
        date2: maps[i][columnDate2],
        time: maps[i][columnTime],
        isCompleted: maps[i][columnIsCompleted] == 1,
      );
    });
  }

  Future<List<Todo>> getCompletedTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableTodo,
        where: '$columnIsCompleted = ?',
        whereArgs: [1]); // Mengambil tugas yang sudah selesai (isCompleted = 1)

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        subtitle: maps[i][columnSubtitle],
        description: maps[i][columnDescription],
        priority: maps[i][columnPriority],
        date: maps[i][columnDate],
        date2: maps[i][columnDate2],
        time: maps[i][columnTime],
        isCompleted: true, // Menandai tugas sebagai selesai
      );
    });
  }

  Future<int> update(Todo todo) async {
    final db = await database;
    return await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int?> delete(int id) async {
    final db = await database;
    return await db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<bool> login(Users user) async {
    final Database db = await database;

    var result = await db.query(tableUsers,
        where: '$columnUserName = ? AND $columnUserPassword = ?',
        whereArgs: [user.usrName, user.usrPassword]);

    return result.isNotEmpty;
  }

  Future<int> signup(Users user) async {
    final Database db = await database;

    return db.insert(tableUsers, user.toMap());
  }

  saveUsername(String text) {}
}
