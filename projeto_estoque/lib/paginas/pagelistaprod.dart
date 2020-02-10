import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_estoque/paginas/pageform.dart';
import 'dart:io';
import 'dart:convert' as converte;
import 'package:projeto_estoque/helpers/databaseHelper.dart';
import '../modelo/produto.dart';

class PageListaProd extends StatefulWidget {
  @override
  _PageListaProdState createState() => _PageListaProdState();
}

class _PageListaProdState extends State<PageListaProd> {
  var _db = DatabaseHelper();
  List<Produto> _produtos = List<Produto>();

  @override
  void initState() {
    super.initState();
    this._db.getProdutos().then((prods) {
      setState(() {
        this._produtos.clear();
        this._produtos = prods;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(6),
          child: _montarlistadinamica(context)),
    );
  }

  _montarlistadinamica(BuildContext context) {
    return FutureBuilder(
        future: _buscardados(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _crialistview(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<Produto>> _buscardados() async {
    List<Produto> lista = new List<Produto>();

    var url = "http://jamil-jov4.localhost.run/produtos";

    http.Response resposta = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    if (resposta.statusCode == HttpStatus.ok) {
      //A chamada aconteceu com sucesso
      var listaretorno =
          converte.jsonDecode(converte.utf8.decode(resposta.bodyBytes));
      for (var prod in listaretorno) {
        //Transformamos nosso mapa em um objeto Produto
        Produto objprod = Produto.fromJson(prod);
        lista.add(objprod);
      }
    } else {
      //Falha ao chamar o serviço
      print("Falha ao receber os dados da Internet.");
    }

    this._produtos.addAll(lista);
    lista.clear();
    return Future.value(this._produtos);
  }

  _crialistview(listaprod) {
    return ListView.builder(
      itemCount: listaprod.length,
      itemBuilder: (context, index) {
        Produto itemprod = listaprod[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/produto.png'),
          ),
          title: Text(itemprod.nome),
          subtitle: Text(itemprod.categoria.toString()),
          trailing: Text(itemprod.quantidade.toString()),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormPage(prod: itemprod)));
          },
        );
      },
    );
  }
}
