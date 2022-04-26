import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseConnection{
  Future<Database> setDatabase() async
  {
    var directory= await getExternalStorageDirectory();
    
    var path=join(directory?.path ?? '','db_login');
    
    var database= await openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }
  Future<void> _createDatabase(Database database,int version ) async{
   String sql="CREATE TABLE friends (id INTEGER PRIMARY KEY,email TEXT,password TEXT);";
   await database.execute(sql);
  }
}