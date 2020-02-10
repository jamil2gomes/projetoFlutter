class Produto {
  int id;
  String nome;
  String descricao;
  int categoria;
  int quantidade;
  bool prioridade;

  Produto(
      {this.nome,
      this.categoria,
      this.quantidade,
      this.prioridade,
      this.descricao});

  // int get id => _id;
  // set id(int id) => _id = id;
  // String get nome => _nome;
  // set nome(String nome) => _nome = nome;
  // String get descricao => _descricao;
  // set descricao(String descricao) => _descricao = descricao;
  // String get categoria => _categoria;
  // set categoria(String categoria) => _categoria = categoria;
  // int get quantidade => _quantidade;
  // set quantidade(int quantidade) => _quantidade = quantidade;
  // bool get prioridade => _prioridade;
  // set prioridade(bool prioridade) => _prioridade = prioridade;

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    categoria = json['categoria'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['categoria'] = this.categoria;
    data['quantidade'] = this.quantidade;

    return data;
  }

  @override
  String toString() {
    return "Produto[$nome, $descricao, $quantidade]";
  }
}
