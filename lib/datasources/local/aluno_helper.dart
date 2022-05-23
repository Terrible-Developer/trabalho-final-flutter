import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/models/aluno.dart';
import 'package:controlealunos/datasources/local/professor_helper.dart';
import 'package:sqflite/sqflite.dart';


const sqlCreateAluno = '''
  CREATE TABLE TbAluno (
    ${Aluno.alunoRa} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Aluno.alunoNome} TEXT,
    ${Aluno.notaAluno} INTEGER,
    ${Aluno.frequenciaAluno} INTEGER,
    ${Aluno.alunoProfessor} INTEGER,
    FOREIGN KEY(${Aluno.alunoProfessor}) REFERENCES ${Professor.tabela}(ra)
  )
''';

class AlunoHelper {
  Future<Aluno> inserir(Aluno aluno) async {
    Database db = await BancoDados().db;

    aluno.ra = await db.insert(Aluno.tabela, aluno.toMap());
    return aluno;
  }

  Future<int> alterar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return db.update(
      Aluno.tabela,
      aluno.toMap(),
      where: '${Aluno.alunoRa} = ?',
      whereArgs: [aluno.ra]
    );
  }

  Future<int> apagar(Aluno aluno) async {
    Database db = await BancoDados().db;

    return await db.delete(Aluno.tabela,
      where: '${Aluno.alunoRa} = ?',
      whereArgs: [aluno.ra]
    );
  }

  Future<List<Aluno>> getByProfessor(int codProfessor) async {
    Professor? professor = await ProfessorHelper().getProfessor(codProfessor);

    if (professor != null) {
      Database db = await BancoDados().db;
      List dados = await db.query(
        Aluno.tabela,
        where: '${Aluno.alunoProfessor} = ?',
        whereArgs: [codProfessor],
        orderBy: Aluno.alunoNome
      );


      return dados.map((e) => Aluno.fromMap(e, professor)).toList();
    }

    return [];
  }

  Future<Aluno?> getAluno(int codAluno) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
      Aluno.tabela,
      where: '${Aluno.alunoRa} = ?',
      whereArgs: [codAluno]
    );

    if (dados.isNotEmpty) {
      int codProfessor = int.parse(dados.first[Aluno.alunoProfessor].toString());
      Professor professor = (await ProfessorHelper().getProfessor(codProfessor))!;
      return Aluno.fromMap(dados.first, professor);
    }
    return null;
  }
}
