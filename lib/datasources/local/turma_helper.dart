import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/models/turma.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

const sqlCreateTurma = '''
    CREATE TABLE $turmaTabela (
      $turmaCodigo INTEGER PRIMARY KEY AUTOINCREMENT,
      $turmaNome TEXT
    )
  ''';

class TurmaHelper {
  Future<Turma> inserir(Turma turma) async {
    Database db = await BancoDados().db;

    turma.codigo = await db.insert(turmaTabela, turma.toMap());
    return turma;
  }

  Future<int> alterar(Turma turma) async {
    Database db = await BancoDados().db;

    return db.update(turmaTabela, turma.toMap(),
      where: '$turmaCodigo = ?',
      whereArgs: [turma.codigo]
    );
  }

  Future<int> apagar(Turma turma) async {
    Database db = await BancoDados().db;

    return db.delete(turmaTabela,
      where: '$turmaCodigo = ?',
      whereArgs: [turma.codigo]
    );
  }

  Future<List<Turma>> getTodos() async {
    Database db = await BancoDados().db;

    //List dados = await db.rawQuery('SELECT * FROM $turmaTabela');
    List dados = await db.query(turmaTabela);

    return dados.map((e) => Turma.fromMap(e)).toList();
  }

  Future<Turma?> getTurma(int codigo) async {
    Database db = await BancoDados().db;

    List dados = await db.query(turmaTabela,
      columns: [turmaCodigo, turmaNome],
      where: '$turmaCodigo = ?',
      whereArgs: [codigo]
    );

    if (dados.isNotEmpty) {
      return Turma.fromMap(dados.first);
    }
    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $turmaTabela')
    ) ?? 0;
  }
}
