class YemekMenu {
  String? corba;
  String? anaYemek;
  String? yanYemek;
  String? garnitur;
  String? ikinciAnaYemek;
  String? gun;
  late bool expanded;

  YemekMenu(
      {this.corba,
        this.anaYemek,
        this.yanYemek,
        this.garnitur,
        this.ikinciAnaYemek,
        this.gun,
        this.expanded = false});

  YemekMenu.fromJson(Map<String, dynamic> json) {
    corba = json['corba'];
    anaYemek = json['anaYemek'];
    yanYemek = json['yanYemek'];
    garnitur = json['garnitur'];
    ikinciAnaYemek = json['ikinciAnaYemek'];
    gun = json['gun'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['corba'] = corba;
    data['anaYemek'] = anaYemek;
    data['yanYemek'] = yanYemek;
    data['garnitur'] = garnitur;
    data['ikinciAnaYemek'] = ikinciAnaYemek;
    data['gun'] = gun;
    return data;
  }
}