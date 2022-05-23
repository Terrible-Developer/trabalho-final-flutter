import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/models/editora.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateEditora = '''
    CREATE TABLE $editoraTabela (
      $editoraCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
      $editoraNome TEXT
    )
  ''';

class EditoraHelper {
  Future<Editora> inserir(Editora editora) async {
    Database db = await BancoDados().db;

    editora.codigo = await db.insert(editoraTabela, editora.toMap());
    return editora;
  }

  Future<int> alterar(Editora editora) async {
    Database db = await BancoDados().db;

    return db.update(editoraTabela, editora.toMap(),
      where: '$editoraCodigo = ?',
      whereArgs: [editora.codigo]
    );
  }

  Future<int> apagar(Editora editora) async {
    Database db = await BancoDados().db;

    return db.delete(editoraTabela,
      where: '$editoraCodigo = ?',
      whereArgs: [editora.codigo]
    );
  }

  Future<List<Editora>> getTodos() async {
    Database db = await BancoDados().db;

    //List dados = await db.rawQuery('SELECT * FROM $editoraTabela');
    List dados = await db.query(editoraTabela);

    return dados.map((e) => Editora.fromMap(e)).toList();
  }

  Future<Editora?> getEditora(int codigo) async {
    Database db = await BancoDados().db;

    List dados = await db.query(editoraTabela,
      columns: [editoraCodigo, editoraNome],
      where: '$editoraCodigo = ?',
      whereArgs: [codigo]
    );

    if (dados.isNotEmpty) {
      return Editora.fromMap(dados.first);
    }
    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $editoraTabela')
    ) ?? 0;
  }
}
