import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/datasources/local/turma_helper.dart';
import 'package:controlealunos/models/turma.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:sqflite/sqflite.dart';


const sqlCreateDisciplina = '''
  CREATE TABLE TbDisciplina (
    ${Disciplina.codigo_disciplina} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Disciplina.nome_disciplina} TEXT,
    ${Disciplina.turma_disciplina} INTEGER,
    FOREIGN KEY(${Disciplina.turma_disciplina}) REFERENCES $turmaTabela($turmaCodigo)
  )
''';

class DisciplinaHelper {
  Future<Disciplina> inserir(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    disciplina.codigo = await db.insert(Disciplina.tabela, disciplina.toMap());
    return disciplina;
  }

  Future<int> alterar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return db.update(
      Disciplina.tabela,
      disciplina.toMap(),
      where: '${Disciplina.codigo_disciplina} = ?',
      whereArgs: [disciplina.codigo]
    );
  }

  Future<int> apagar(Disciplina disciplina) async {
    Database db = await BancoDados().db;

    return await db.delete(Disciplina.tabela,
      where: '${Disciplina.codigo_disciplina} = ?',
      whereArgs: [disciplina.codigo]
    );
  }

  Future<List<Disciplina>> getByTurma(int codTurma) async {
    Turma? turma = await TurmaHelper().getTurma(codTurma);

    if (turma != null) {
      Database db = await BancoDados().db;

      List dados = await db.query(
        Disciplina.tabela,
        where: '${Disciplina.turma_disciplina} = ?',
        whereArgs: [codTurma],
        orderBy: Disciplina.nome_disciplina
      );

      return dados.map((e) => Disciplina.fromMap(e, turma)).toList();
    }

    return [];
  }

  Future<Disciplina?> getDisciplina(int codDisciplina) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
      Disciplina.tabela,
      where: '${Disciplina.codigo_disciplina} = ?',
      whereArgs: [codDisciplina]
    );

    if (dados.isNotEmpty) {
      int codTurma = int.parse(dados.first[Disciplina.turma_disciplina].toString());
      Turma turma = (await TurmaHelper().getTurma(codTurma))!;
      return Disciplina.fromMap(dados.first, turma);
    }
    return null;
  }
}
