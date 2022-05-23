import 'package:flutter/material.dart';

class MensagemAlerta {
  static Future show({required BuildContext context, required String titulo,
    required String texto, required List<Widget> botoes}) {

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(texto),
          actions: botoes,
        );
      }
    );
  }
}