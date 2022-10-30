class Notlar {
  late final String dersKodu;
  late final String dersAdi;
  late final String odevBir;
  late final String odevIki;
  late final String vizeSinavi;
  late final String finalSinavi;
  late final String toplamNot;
  late bool expanded;


  Notlar({this.expanded = false,
    required this.dersKodu,
    required this.dersAdi,
    required this.odevBir,
    required this.odevIki,
    required this.vizeSinavi,
    required this.finalSinavi,
    required this.toplamNot});

  static Notlar fromJson(json) => Notlar(
        dersKodu: json['dersKodu'],
        dersAdi: json['dersAdi'],
        odevBir: json['odevBir'],
        odevIki: json['odevIki'],
        vizeSinavi: json['vizeSinavi'],
        finalSinavi: json['finalSinavi'],
        toplamNot: json['toplamNot']
      );
}