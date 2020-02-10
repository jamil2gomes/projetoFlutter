import 'package:path_provider/path_provider.dart';
import '../modelo/produto.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String produtoTable = "produto";
  String colId = "id";
  String colNome = "nome";
  String colDesc = "descricao";
  String colQtd = "quantidade";
  String colPrioridade = "prioridade";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'produto.db';

    var produtoDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return produtoDB;
  }

  void _createDB(Database db, int version) async {
    String sql =
        "CREATE TABLE $produtoTable ($colId INTERGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colDesc TEXT, $colPrioridade NUMERIC, $colQtd INTEGER)";

    await db.execute(sql);
  }

  Future<int> insert(Produto produto) async {
    Database db = await this.database;

    var resultado = await db.insert(produtoTable, produto.toJson());

    return resultado;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await this.database;
    return await db.query(produtoTable);
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
