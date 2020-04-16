import 'package:despesas_app/models/date.dart';
import 'package:despesas_app/models/gasto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FinancasHelper {
  static final String tableName = "date";
  static final String secondTableName = "gasto";

  static final FinancasHelper _financasHelper = FinancasHelper.internal();
  Database _db;
  factory FinancasHelper() {
    return _financasHelper;
  }

  FinancasHelper.internal();

  get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initializeDB();
    return _db;
  }

  initializeDB() async {
    final caminhaDB = await getDatabasesPath();
    final localDB = join(caminhaDB, "db_financas.db");

    var db = await openDatabase(
      localDB,
      version: 1,
      onCreate: _onCreateDB,
    );
    return db;
  }

  _onCreateDB(Database db, int version) async {
    String sql = "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "month VARCHAR,"
        "year VARCHAR,"
        "salary VARCHAR"
        ")";
    await db.execute(sql);
    String sql2 = "CREATE TABLE $secondTableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title VARCHAR,"
        "value VARCHAR,"
        "idDate INTEGER,"
        "FOREIGN KEY (idDate) REFERENCES $tableName(id)"
        ")";
    // tabela que irei criar
    await db.execute(sql2);

    //executand comando SQL
  }

  listMonth() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $tableName ORDER BY id DESC";
    List months = await bancoDados.rawQuery(sql);

    print(months);
    return months;
  }

  insertDate(Date date) async {
    var bancoDados = await db;

    return await bancoDados.insert(
      tableName,
      date.toJson(),
    );
  }

  deleteDate(int id) async {
    var bancoDados = await db;

    return await bancoDados.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  updateDate(Date date) async {
    var bancoDados = await db;

    return await bancoDados.update(
      tableName,
      date.toJson(),
      where: "id = ?",
      whereArgs: [date.id],
    );
  }

  insertGasto(Gasto gasto) async {
    var bancoDados = await db;

    return await bancoDados.insert(
      secondTableName,
      gasto.toJson(),
    );
  }

  listGastos(int idDate) async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $secondTableName WHERE idDate = $idDate";
    List gastos = await bancoDados.rawQuery(sql);
    print(gastos);
    return gastos;
  }
}
