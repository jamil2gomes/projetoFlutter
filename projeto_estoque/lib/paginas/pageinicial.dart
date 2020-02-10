import 'package:flutter/material.dart';
import 'pageform.dart';
// import 'pagelistatcc.dart';

class PageInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppEstoque'),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      color: Colors.orange,
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          _imagem("assets/images/productcheck.png"),
          _texto('Gerenciamento de Estoque'),
          _botao(context),
        ],
      ),
    );
  }

  _imagem(String url) {
    return Image.asset(url);
  }

  _texto(String txt) {
    return Text(
      txt,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  _botao(BuildContext context) {
    return RaisedButton(
      child: Text('AVANÇAR'),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormPage();
        }));
      },
    );
  }
}
