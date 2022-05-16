import 'package:sqflite/sqflite.dart';
import 'db_connection.dart';

class Repo {
  late DatabaseConnection _databaseConnection;
  Repo() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readUser(String email, String password) async {
    var connection = await database;
    return await connection?.rawQuery(
        "SELECT * FROM user WHERE email = '$email' and password = '$password'");
  }

  

 
}
