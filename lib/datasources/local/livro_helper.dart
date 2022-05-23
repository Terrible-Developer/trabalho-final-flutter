import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/datasources/local/editora_helper.dart';
import 'package:controlealunos/models/editora.dart';
import 'package:controlealunos/models/livro.dart';
import 'package:sqflite/sqflite.dart';

class LivroHelper {
  static const sqlCreate = '''
    CREATE TABLE ${Livro.tabela} (
      ${Livro.codigo_coluna} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Livro.nome_coluna} TEXT,
      ${Livro.editora_coluna} INTEGER,
      FOREIGN KEY(${Livro.editora_coluna}) REFERENCES $editoraTabela($editoraCodigo)
    )
  ''';

  Future<Livro> inserir(Livro livro) async {
    Database db = await BancoDados().db;

    livro.codigo = await db.insert(Livro.tabela, livro.toMap());
    return livro;
  }

  Future<int> alterar(Livro livro) async {
    Database db = await BancoDados().db;

    return db.update(
      Livro.tabela,
      livro.toMap(),
      where: '${Livro.codigo_coluna} = ?',
      whereArgs: [livro.codigo]
    );
  }

  Future<int> apagar(Livro livro) async {
    Database db = await BancoDados().db;

    return await db.delete(Livro.tabela,
      where: '${Livro.codigo_coluna} = ?',
      whereArgs: [livro.codigo]
    );
  }

  Future<List<Livro>> getByEditora(int codEditora) async {
    Editora? editora = await EditoraHelper().getEditora(codEditora);

    if (editora != null) {
      Database db = await BancoDados().db;

      List dados = await db.query(
        Livro.tabela,
        where: '${Livro.editora_coluna} = ?',
        whereArgs: [codEditora],
        orderBy: Livro.nome_coluna
      );

      return dados.map((e) => Livro.fromMap(e, editora)).toList();
    }

    return [];
  }

  Future<Livro?> getLivro(int codLivro) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
      Livro.tabela,
      where: '${Livro.codigo_coluna} = ?',
      whereArgs: [codLivro]
    );

    if (dados.isNotEmpty) {
      int codEditora = int.parse(dados.first[Livro.editora_coluna].toString());
      Editora editora = (await EditoraHelper().getEditora(codEditora))!;
      return Livro.fromMap(dados.first, editora);
    }
    return null;
  }
}
