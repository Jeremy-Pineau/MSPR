class Promotion {
  int _id;
  String _codePromo;
  String _detail;

  Promotion({int id, String codePromo, String detail}) {
    this._id = id;
    this._codePromo = codePromo;
    this._detail = detail;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get codePromo => _codePromo;
  set codePromo(String codePromo) => _codePromo = codePromo;
  String get detail => _detail;
  set detail(String detail) => _detail = detail;

  Promotion.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _codePromo = json['codePromo'];
    _detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['codePromo'] = this._codePromo;
    data['detail'] = this._detail;
    return data;
  }
}