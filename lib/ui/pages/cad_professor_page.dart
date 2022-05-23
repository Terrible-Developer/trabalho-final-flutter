import 'package:controlealunos/datasources/local/disciplina_helper.dart';
import 'package:controlealunos/datasources/local/professor_helper.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:flutter/material.dart';

class CadProfessorPage extends StatefulWidget {
  final Disciplina disciplina;
  final Professor? professor;

  const CadProfessorPage(this.disciplina, {this.professor, Key? key}) : super(key: key);

  @override
  State<CadProfessorPage> createState() => _CadProfessorPageState();
}

class _CadProfessorPageState extends State<CadProfessorPage> {
  final _professorHelper = ProfessorHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.professor != null) {
      _nomeController.text = widget.professor!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro Professor - ${widget.disciplina.nome}')),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome do professor'
          ),
          ElevatedButton(
            onPressed: _salvarProfessor,
            child: const Text('Salvar')
          ),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.professor != null) {
      return ElevatedButton(
          onPressed: _excluirProfessor,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  void _excluirProfessor() {
    _professorHelper.apagar(widget.professor!);
    Navigator.pop(context);
  }

  void _salvarProfessor() {
    if (widget.professor != null) {
      widget.professor!.nome = _nomeController.text;
      _professorHelper.alterar(widget.professor!);
    }
    else {
      _professorHelper.inserir(Professor(
          nome: _nomeController.text,
          disciplina: widget.disciplina
      ));
    }
    Navigator.pop(context);
  }
}
