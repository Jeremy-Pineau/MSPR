class User {

  String _nom;
  String _prenom;
  String _adresse;
  String _mail;
  String _mdp;

  User(this._nom, this._prenom, this._adresse, this._mail, this._mdp);

  constructorUser({String nom, String prenom, String adresse, String mail, String mdp}) {
    this._nom = nom;
    this._prenom = prenom;
    this._adresse = adresse;
    this._mail = mail;
    this._mdp = mdp;
  }

  // Properties
  String get nom => _nom;
  set nom(String nom) => _nom = nom;
  String get prenom => _prenom;
  set prenom(String prenom) => _prenom = prenom;
  String get adresse => _adresse;
  set adresse(String adresse) => _adresse = adresse;
  String get mail => _mail;
  set mail(String mail) => _mail = mail;
  String get mdp => _mdp;
  set mdp(String mdp) => _mdp = mdp;

  // create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
  _nom = json['nom'];
  _prenom = json['prenom'];
  _adresse = json['adresse'];
  _mail = json['mail'];
  _mdp = json['mdp'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this._nom;
    data['prenom'] = this._prenom;
    data['adresse'] = this._adresse;
    data['mail'] = this._mail;
    data['mdp'] = this._mdp;
    return data;
  }
}