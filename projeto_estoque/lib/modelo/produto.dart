class Produto {
  int _id;
  String _nome;
  String _descricao;
  String _categoria;
  int _quantidade;
  bool _prioridade;

  Produto(
      {int id,
      String nome,
      String categoria,
      int quantidade,
      bool prioridade,
      String descricao}) {
    this._id = id;
    this._nome = nome;
    this._descricao = descricao;
    this._categoria = categoria;
    this._quantidade = quantidade;
    this._prioridade = prioridade;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;
  String get categoria => _categoria;
  set categoria(String categoria) => _categoria = categoria;
  int get quantidade => _quantidade;
  set quantidade(int quantidade) => _quantidade = quantidade;
  bool get prioridade => _prioridade;
  set prioridade(bool prioridade) => _prioridade = prioridade;

  Produto.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    _descricao = json['descricao'];
    _categoria = json['categoria'];
    _quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nome'] = this._nome;
    data['descricao'] = this._descricao;
    data['categoria'] = this._categoria;
    data['quantidade'] = this._quantidade;

    return data;
  }
}
