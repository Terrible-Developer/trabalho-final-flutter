import 'package:controlealunos/datasources/local/editora_helper.dart';
import 'package:controlealunos/datasources/local/livro_helper.dart';
import 'package:controlealunos/models/editora.dart';
import 'package:controlealunos/models/livro.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:flutter/material.dart';

class CadLivroPage extends StatefulWidget {
  final Editora editora;
  final Livro? livro;

  const CadLivroPage(this.editora, {this.livro, Key? key}) : super(key: key);

  @override
  State<CadLivroPage> createState() => _CadLivroPageState();
}

class _CadLivroPageState extends State<CadLivroPage> {
  final _livroHelper = LivroHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _nomeController.text = widget.livro!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro Livro - ${widget.editora.nome}')),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome do livro'
          ),
          ElevatedButton(
            onPressed: _salvarLivro,
            child: const Text('Salvar')
          ),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.livro != null) {
      return ElevatedButton(
          onPressed: _excluirLivro,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  void _excluirLivro() {
    _livroHelper.apagar(widget.livro!);
    Navigator.pop(context);
  }

  void _salvarLivro() {
    if (widget.livro != null) {
      widget.livro!.nome = _nomeController.text;
      _livroHelper.alterar(widget.livro!);
    }
    else {
      _livroHelper.inserir(Livro(
          nome: _nomeController.text,
          editora: widget.editora
      ));
    }
    Navigator.pop(context);
  }
}
