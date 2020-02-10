import 'package:flutter/material.dart';
import '../modelo/produto.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PageForm extends StatefulWidget {
  PageForm({Key key}) : super(key: key);

  @override
  _PageFormState createState() => _PageFormState();
}

class _PageFormState extends State<PageForm> {
  final _formKey = GlobalKey<FormState>();
  var produto = new Produto();

  bool _isPrioridade = false;

  void onChanged(bool value) {
    setState(() {
      _isPrioridade = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Produto"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nome Produto', hintText: 'Detergente'),
                  validator: (input) =>
                      input.length < 3 ? 'Nome invalido' : null,
                  onSaved: (input) => produto.nome = input,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Descrição', hintText: 'Detergente X....'),
                  validator: (input) => input.length == 0
                      ? 'Por favor, digite uma descrição..'
                      : null,
                  onSaved: (input) => produto.descricao = input,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Categoria', hintText: 'Limpeza'),
                  validator: (input) =>
                      input.length < 3 ? 'Digite uma categoria válida' : null,
                  onSaved: (input) => produto.categoria = input,
                ),
                // Row(
                //   children: <Widget>[
                //     Text('Masculino'),
                //     Radio(
                //       value: 0,
                //       groupValue: selectedRadio,
                //       onChanged: (int val) {
                //         _setSelectedRadio(val);
                //         usuario.sexo = selectedRadio;
                //       },
                //     ),
                //     Text('Feminino'),
                //     Radio(
                //       value: 1,
                //       groupValue: selectedRadio,
                //       onChanged: (val) {
                //         _setSelectedRadio(val);
                //         usuario.sexo = selectedRadio;
                //       },
                //     ),
                //   ],
                // ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isPrioridade,
                      onChanged: (bool value) {
                        onChanged(value);
                        produto.prioridade = _isPrioridade;
                      },
                    ),
                    Text('Prioridade'),
                  ],
                ),
                Container(
                  child: new RaisedButton(
                    child: new Text(
                      'Salvar',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      String texto = "";
                      submit()
                          ? texto = "Produto salvo com sucesso"
                          : texto = "Erro ao salvar Produto";

                      final snackBar = SnackBar(
                        content: Text(texto),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print(produto);
      return true;
    } else {
      return false;
    }
  }
}
