import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/model/to_do.dart';

class DataBase {
  late Database _database;
  String tableName = 'todo';

  Future<Database> get database async {
    _database = await initDB();

    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), '$tableName.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          success INTEGER NOT NULL,
          content TEXT NOT NULL,
          date TEXT NOT NULL,
          isDeleted INTEGER NOT NULL
        )''');
      },
    );
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(
        maps.length, (index) => Todo.createTodoByMap(maps[index]));
  }

  Future<List<Todo>> getTodoByDate(DateTime date) async {
    String strDate = Todo.getDateStr(date);

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM $tableName WHERE date = "$strDate" AND isDeleted = 0 ORDER BY success ASC',
    );

    if (maps.isEmpty) return [];

    return List.generate(maps.length, (index) {
      return Todo.createTodoByMap(maps[index]);
    });
  }

  insert(Todo todo) async {
    final db = await database;

    await db.insert(tableName, todo.toMap());
  }

  updateSuccess(Todo todo) async {
    final db = await database;
    int newSuccess = Todo.changeBoolToInt(!todo.success);

    await db.rawUpdate(
        'UPDATE $tableName SET success = $newSuccess WHERE id = ${todo.id}');
  }
}
