class Dersler {
  late final String dersKodu;
  late final String dersAdi;
  late final String puanStr;
  late final String puan;
  late final String harfStr;
  late final String harfNotu;
  late bool expanded;


  Dersler({this.expanded = false,
    required this.dersKodu,
    required this.dersAdi,
    required this.puanStr,
    required this.puan,
    required this.harfStr,
    required this.harfNotu});

  static Dersler fromJson(json) => Dersler(
      dersKodu: json['dersKodu'],
      dersAdi: json['dersAdi'],
      puanStr: json['puanStr'],
      puan: json['puan'],
      harfStr: json['harfStr'],
      harfNotu: json['harfNotu']);



}