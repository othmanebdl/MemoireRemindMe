import 'package:sqflite/sqflite.dart' as sql;

DateTime selectedDate = DateTime.now();

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""  
   CREATE TABLE task(
     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
     title TEXT,
     description TEXT,
     typetask TEXT,
     jour INTEGER,
     mois INTEGER,
     year INTEGER,
     hour INTEGER,
     minute INTEGER



   ) 
    
     """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('task.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> insert(String title, String description, String typetask,
      int jour, int mois, int year, int hour, int minute) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'typetask': typetask,
      'jour': jour,
      'mois': mois,
      'year': year,
      'hour': hour,
      'minute': minute
    };
    return await db.insert('task', data);
  }

  static Future<List<Map<String, dynamic>>> getDatatask() async {
    final db = await SQLHelper.db();
    return db.query('task');
  }
    static Future<List<Map<String, dynamic>>> getDatataskcour() async {
    final db = await SQLHelper.db();
    return db.query('task',where: "typetask = ?",whereArgs: ['Lesson']);
  }
    static Future<List<Map<String, dynamic>>> getDatataskdevoir() async {
    final db = await SQLHelper.db();
    return db.query('task',where: "typetask = ?",whereArgs: ['Homework']);
  }

  /*static Future<List<Map<String, dynamic>>> getDatataskToday() async {
    final db = await SQLHelper.db();
    return db.query('task');
  }*/

  static Future<List<Map<String, dynamic>>> getDataWithsearch(
      String title) async {
    if (title == "") return [];
    final db = await SQLHelper.db();
    return db.query('task', where: "title LIKE ?", whereArgs: ['%$title%']);
  }

  static Future<int> updateData(
      int id,
      String title,
      String description,
      String typetask,
      int jour,
      int mois,
      int year,
      int hour,
      int minute) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'typetask': typetask,
      'jour': jour,
      'mois': mois,
      'year': year,
      'hour': hour,
      'minute': minute
    };
    return await db.update('task', data, where: "id=$id");
  }

  static Future<int> deleteTask(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('task', where: "id =$id");
  }
}
