import 'package:controlealunos/datasources/local/aluno_helper.dart';
import 'package:controlealunos/models/aluno.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/ui/pages/cad_aluno_page.dart';
import 'package:flutter/material.dart';

class AlunosPage extends StatefulWidget {
  final Professor professor;

  const AlunosPage(this.professor, {Key? key}) : super(key: key);

  @override
  State<AlunosPage> createState() => _AlunosPageState();
}

class _AlunosPageState extends State<AlunosPage> {
  final _alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.professor.nome)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarAluno,
      ),
      body: FutureBuilder(
        future: _alunoHelper.getByProfessor(widget.professor.ra ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Aluno>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Aluno> listaDados) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: listaDados.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaDados[index]);
      }
    );
  }

  Widget _criarItemLista(Aluno aluno) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(aluno.nome, style: const TextStyle(fontSize: 28),),
        ),
      ),
      onTap: () => _cadastrarAluno(aluno: aluno),
    );
  }

  void _cadastrarAluno({Aluno? aluno}) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => CadAlunoPage(widget.professor, aluno: aluno,)
    ));

    setState(() { });
  }
}
