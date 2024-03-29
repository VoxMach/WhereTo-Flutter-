import 'package:WhereTo/BarangaylocalList/barangay_class.dart';

class BaranggayRespone{

  final List<Barangays> bararangSaika;
  final String error;

  BaranggayRespone(this.bararangSaika, this.error);

  BaranggayRespone.fromJson(List<dynamic> json)
  : bararangSaika = 
  json.cast<Map<String,dynamic>>()
  .map((e) => new Barangays.fromJson(e))
  .toList()
  ,error = "";

  BaranggayRespone.withError(String errorval)
  : bararangSaika = List(),
  error = errorval;

}