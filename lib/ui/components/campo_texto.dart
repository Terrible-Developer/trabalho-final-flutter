import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final TextInputType? teclado;

  const CampoTexto({
    required this.controller,
    required this.texto,
    this.teclado,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: teclado ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: texto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
    );
  }
}
