import 'package:aula_03_pos/datasources/local/livro_helper.dart';
import 'package:aula_03_pos/models/editora.dart';
import 'package:aula_03_pos/models/livro.dart';
import 'package:aula_03_pos/ui/pages/cad_livro_page.dart';
import 'package:flutter/material.dart';

class LivrosPage extends StatefulWidget {
  final Editora editora;

  const LivrosPage(this.editora, {Key? key}) : super(key: key);

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  final _livroHelper = LivroHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.editora.nome)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarLivro,
      ),
      body: FutureBuilder(
        future: _livroHelper.getByEditora(widget.editora.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Livro>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Livro> listaDados) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: listaDados.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaDados[index]);
      }
    );
  }

  Widget _criarItemLista(Livro livro) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(livro.nome, style: const TextStyle(fontSize: 28),),
        ),
      ),
      onTap: () => _cadastrarLivro(livro: livro),
    );
  }

  void _cadastrarLivro({Livro? livro}) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => CadLivroPage(widget.editora, livro: livro,)
    ));

    setState(() { });
  }
}
