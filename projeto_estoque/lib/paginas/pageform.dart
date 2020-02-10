import 'package:flutter/material.dart';
import 'package:projeto_estoque/modelo/produto.dart';
import 'package:projeto_estoque/helpers/databaseHelper.dart';
import 'package:projeto_estoque/paginas/pagelistaprod.dart';

class FormPage extends StatefulWidget {
  final Produto prod;

  FormPage({this.prod});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String texto = "";
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Produto produto;
  var db = DatabaseHelper();

  final _nome = TextEditingController();
  final _desc = TextEditingController();
  final _qtd = TextEditingController();
  final _cat = TextEditingController();
  final _prio = TextEditingController();

  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;

    if (widget.prod == null) {
      produto = Produto();
    } else {
      produto = Produto.fromJson(widget.prod.toJson());

      _nome.text = produto.nome;
      _cat.text = produto.categoria.toString();
      _desc.text = produto.descricao;
      _qtd.text = produto.quantidade.toString();
      _prio.text = produto.prioridade.toString();
    }
  }

  _setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool _isPrioridade = false;

  void onChanged(bool value) {
    setState(() {
      _isPrioridade = value;
    });
  }

  showSnackBar(String texto) {
    final snackBar = SnackBar(
      content: Text(texto),
      duration: Duration(seconds: 4),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Formulário Produto")),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nome Produto', hintText: 'Detergente'),
                  validator: (input) =>
                      input.length < 3 ? 'Nome invalido' : null,
                  onSaved: (input) => produto.nome = input,
                ),
                TextFormField(
                  controller: _desc,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Descrição', hintText: 'Detergente X....'),
                  validator: (input) => input.length == 0
                      ? 'Por favor, digite uma descrição..'
                      : null,
                  onSaved: (input) => produto.descricao = input,
                ),
                TextFormField(
                  controller: _qtd,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  validator: (input) =>
                      input.length <= 0 ? 'Digite uma quantidade válida' : null,
                  onSaved: (input) => produto.quantidade = int.parse(input),
                ),
                Row(
                  children: <Widget>[
                    Text('Limpeza'),
                    Radio(
                      value: 0,
                      groupValue: selectedRadio,
                      onChanged: (int val) {
                        _setSelectedRadio(val);
                        produto.categoria = selectedRadio;
                      },
                    ),
                    Text('Bebida'),
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        _setSelectedRadio(val);
                        produto.categoria = selectedRadio;
                      },
                    ),
                    Text('Alimento'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        _setSelectedRadio(val);
                        produto.categoria = selectedRadio;
                      },
                    ),
                  ],
                ),
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
                      if (submit()) {
                        texto = "Produto salvo com sucesso";
                        showSnackBar(texto);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PageListaProd();
                        }));
                      }

                      texto = "Erro ao salvar Produto";
                      showSnackBar(texto);
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
      db.insert(produto);
      print(produto.toString());
      return true;
    }
    return false;
  }
}
