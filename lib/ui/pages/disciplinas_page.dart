import 'package:controlealunos/datasources/local/disciplina_helper.dart';
import 'package:controlealunos/models/turma.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/ui/pages/cad_disciplina_page.dart';
import 'package:controlealunos/ui/pages/professores_page.dart';
import 'package:flutter/material.dart';

class DisciplinasPage extends StatefulWidget {
  final Turma turma;

  const DisciplinasPage(this.turma, {Key? key}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final _disciplinaHelper = DisciplinaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.turma.nome)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarDisciplina,
      ),
      body: FutureBuilder(
        future: _disciplinaHelper.getByTurma(widget.turma.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Disciplina>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Disciplina> listaDados) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: listaDados.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaDados[index]);
      }
    );
  }

  Widget _criarItemLista(Disciplina disciplina) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(disciplina.nome, style: const TextStyle(fontSize: 28),),
        ),
      ),
      onTap: () => _abrirListaProfessores(disciplina),
    );
  }

  void _abrirListaProfessores(Disciplina disciplina) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ProfessoresPage(disciplina)
    ));
  }

  void _cadastrarDisciplina({Disciplina? disciplina}) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => CadDisciplinaPage(widget.turma, disciplina: disciplina,)
    ));

    setState(() { });
  }
}
