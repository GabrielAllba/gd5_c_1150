import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE employee(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      email TEXT,
      deskripsi TEXT
      )
      """);
  }

  // call db
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'employee.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // insert employee

  static Future<int> addEmployee(
      String name, String email, String deskripsi) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email, 'deskripsi': deskripsi};
    return await db.insert('employee', data);
  }

  // read employee
  static Future<List<Map<String, dynamic>>> getEmployee() async {
    final db = await SQLHelper.db();
    return db.query('employee');
  }

  // update employee
  static Future<int> editEmployee(
      int id, String name, String email, String deskripsi) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email, 'deskripsi': deskripsi};
    return await db.update('employee', data, where: "id = $id");
  }

  // delete employee
  static Future<int> deleteEmployee(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('employee', where: "id = $id");
  }
}
