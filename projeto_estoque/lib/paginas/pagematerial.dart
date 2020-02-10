import 'package:flutter/material.dart';
import 'pageinicial.dart';

class PageMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AppEstoque',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: PageInicial());
  }
}
