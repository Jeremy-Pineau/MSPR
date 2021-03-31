import 'package:scanqrcode/model/Historique.dart';
import 'package:scanqrcode/model/Promotion.dart';

class HistoData {
  static List<Promotion> _promos = [];
  static List<Historique> _histos = [];
  static List<Historique> get histos => _histos;
  static List<Promotion> get promos => _promos;
}