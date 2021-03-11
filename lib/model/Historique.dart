class Historique {
  int _id;
  int _idPromo;
  int _idUser;
  DateTime _dateScan;

  Historique({int id, int idPromo, int idUser, DateTime dateScan}) {
    this._id = id;
    this._idPromo = idPromo;
    this._idUser = idUser;
    this._dateScan = dateScan;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get idPromo => _idPromo;
  set idPromo(int idPromo) => _idPromo = idPromo;
  int get idUser => _idUser;
  set idUser(int idUser) => _idUser = idUser;
  DateTime get dateScan => _dateScan;
  set dateScan(DateTime dateScan) => _dateScan = dateScan;


  Historique.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idPromo = json['idPromo'];
    _idUser = json['idUser'];
    _dateScan = DateTime.parse(json['dateScan']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['idPromo'] = this._idPromo;
    data['idUser'] = this._idUser;
    data['dateScan'] = this._dateScan;
    return data;
  }
}