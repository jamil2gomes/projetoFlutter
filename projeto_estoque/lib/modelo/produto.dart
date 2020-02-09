class Produto {
  int id;
  String nome;
  String categoria;
  int quantidade;

  Produto({this.id, this.nome, this.categoria, this.quantidade});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    categoria = json['categoria'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['categoria'] = this.categoria;
    data['quantidade'] = this.quantidade;
    return data;
  }
}