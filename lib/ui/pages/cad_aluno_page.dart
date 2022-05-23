import 'package:controlealunos/datasources/local/professor_helper.dart';
import 'package:controlealunos/datasources/local/aluno_helper.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/models/aluno.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:controlealunos/ui/pages/aprovado_page.dart';
import 'package:controlealunos/ui/pages/reprovado_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CadAlunoPage extends StatefulWidget {
  final Professor professor;
  final Aluno? aluno;

  const CadAlunoPage(this.professor, {this.aluno, Key? key}) : super(key: key);

  @override
  State<CadAlunoPage> createState() => _CadAlunoPageState();
}

class _CadAlunoPageState extends State<CadAlunoPage> {
  final _alunoHelper = AlunoHelper();
  final _nomeController = TextEditingController();
  final _notaController = TextEditingController();
  final _frequenciaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.aluno != null) {
      _nomeController.text = widget.aluno!.nome;
      _notaController.text = widget.aluno!.nota.toString();
      _frequenciaController.text = widget.aluno!.frequencia.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro Aluno - ${widget.professor.nome}')),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome do aluno'
          ),
          CampoTexto(
            controller: _notaController,
            texto: 'Nota na disciplina',
            teclado: TextInputType.number
          ),
          CampoTexto(
            controller: _frequenciaController,
            texto: 'Frequência na disciplina',
            teclado: TextInputType.number
          ),
          ElevatedButton(
            onPressed: _salvarAluno,
            child: const Text('Salvar')
          ),
          _criarBotaoExcluir(),
          _criarBotaoAprovacao()
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.aluno != null) {
      return ElevatedButton(
          onPressed: _excluirAluno,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  Widget _criarBotaoAprovacao(){
    if(widget.aluno != null){
      return ElevatedButton(
        onPressed: _aprovarAluno,
        child: const Text('Aprovar')
      );
    }
    return new Scaffold();
  }

  void _excluirAluno() {
    _alunoHelper.apagar(widget.aluno!);
    Navigator.pop(context);
  }

  void _aprovarAluno(){
    if(widget.aluno?.nota != null && widget.aluno?.frequencia != null){
      if(widget.aluno!.nota >= 60 && widget.aluno!.frequencia >= 70){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AprovadoPage()
        ));
      }
      else{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ReprovadoPage()
        ));
      }
    }
  }

  void _salvarAluno() {
    if (widget.aluno != null) {
      widget.aluno!.nome = _nomeController.text;
      _alunoHelper.alterar(widget.aluno!);
    }
    else {
      _alunoHelper.inserir(Aluno(
          nome: _nomeController.text,
          nota: int.parse(_notaController.text),
          frequencia: int.parse(_frequenciaController.text),
          professor: widget.professor
      ));
    }
    Navigator.pop(context);
  }
}
