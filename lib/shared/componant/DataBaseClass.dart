import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  String? DatabasePath;
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initialDatabase() async {
    print("initialDatabase_______________________");

    String databaseName = 'LocalDataBase';
    String path = await getDatabasesPath();
    DatabasePath = path;
    String databasePath = join(path, databaseName);

    Database mydb = await openDatabase(
      databasePath,
      version: 1,
      onCreate: await _oncreateMethode,
      onUpgrade: _onUpgradeMethode,
    );

    return mydb;
  }

  _oncreateMethode(Database db, int version) async {
    print("_oncreateMethode_______________________");

    // Batch().execute(sql)
    //TITLE,DATA,TIME,STATUS
    await db.execute(
        "CREATE TABLE TASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
    await db.execute(
        "CREATE TABLE DoneTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
    await db.execute(
        "CREATE TABLE DraftTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
  }

  _onUpgradeMethode(Database database, int oldVersion, int newVersion) async {
    print("_onUpgradeMethode_______________________");
    await database.execute(
        "CREATE TABLE DraftTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
  }

  Future<List<Map>> readData({required String sqlCommand}) async {
    print("readData by sql command $sqlCommand ______________________");
    Database? myDb = await db;
    Future<List<Map<String, Object?>>> responce = myDb!.rawQuery(sqlCommand);
    return responce;
  }

  Future<List<Map<String, Object?>>> insertData({
    required String tableName,
    required title,
    required date,
    required time,
    required status,
  }) async {
    String sqlCommand =
        'INSERT INTO $tableName(TITLE,DATE,TIME,STATUS) VALUES("$title", "$date", "$time","$status")';
    print("insertData by sql command $sqlCommand ______________________");

    Database? mydb = await db;
    var response = await mydb!.rawQuery(sqlCommand);
    return response;
  }

  Future<int> DeleteData(
      {required String rowData, required String tableName}) async {
    String sqlCommand = 'DELETE FROM $tableName WHERE TITLE = "$rowData"';
    print("DeleteData $sqlCommand ______________________");
    Database? mydb = await db;
    int responce = await mydb!
        .rawDelete('DELETE FROM $tableName WHERE TITLE = "$rowData"');
    return responce;
  }

  Future<int> DeleteTableData({required String tableName}) async {
    print("DeleteTableData $tableName ______________________");
    Database? mydb = await db;
    int responce = await mydb!.rawDelete('DELETE FROM "$tableName"');
    return responce;
  }

/*Future<void> DeleteDataBase() async {
    print("trying to Delete database");

    Database? mydb = await db;
     await deleteDatabase(DatabasePath!).then((value) {

     }).catchError((e) {
      print('Got error: $e');
      return 42; // Future completes with 42.
      });

  }*/
}
