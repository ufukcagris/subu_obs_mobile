class DersProg {
  String? dersSaati;
  String? dersKodu;
  String? dersAdi;
  String? ogretmen;
  String? derslik;
  String? grup;
  String? gun;
  late bool expanded;

  DersProg(
      {this.dersSaati,
      this.dersKodu,
      this.dersAdi,
      this.ogretmen,
      this.derslik,
      this.grup,
        this.gun,
      this.expanded = false});

  DersProg.fromJson(Map<String, dynamic> json) {
    dersSaati = json['dersSaati'];
    dersKodu = json['dersKodu'];
    dersAdi = json['dersAdi'];
    ogretmen = json['ogretmen'];
    derslik = json['derslik'];
    grup = json['grup'];
    gun = json['gun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dersSaati'] = dersSaati;
    data['dersKodu'] = dersKodu;
    data['dersAdi'] = dersAdi;
    data['ogretmen'] = ogretmen;
    data['derslik'] = derslik;
    data['grup'] = grup;
    data['gun'] = gun;
    return data;
  }
}
