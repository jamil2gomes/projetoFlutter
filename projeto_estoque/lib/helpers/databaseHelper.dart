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
  String colCat = "categoria";
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
    String path = directory.path + 'produtoDB.db';

    var produtoDB = await openDatabase(path, version: 2, onCreate: _createDB);
    return produtoDB;
  }

  void _createDB(Database db, int version) async {
    String sql =
        "CREATE TABLE $produtoTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colDesc TEXT, $colPrioridade NUMERIC, $colQtd INTEGER, $colCat INTEGER)";

    await db.execute(sql);
  }

  Future<int> insert(Produto produto) async {
    Database db = await this.database;

    var resultado = await db.insert(produtoTable, produto.toJson());

    return resultado;
  }

  Future<List<Produto>> getProdutos() async {
    Database db = await this.database;
    var resultado = await db.query(produtoTable);

    List<Produto> lista = resultado.isNotEmpty
        ? resultado.map((c) => Produto.fromJson(c)).toList()
        : [];

    return lista;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
