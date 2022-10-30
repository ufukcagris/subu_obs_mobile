class KartBilgi {
  double? kartBakiye;
  String? sonYukleme;
  int? sonYuklemeTutar;
  String? kartTuru;
  double? sonHarcamaTutari;
  String? kartNo;
  String? ogrenciAd;
  String? ogrenciSoyad;
  String? tcNo;
  String? okulBolum;
  String? ogrenciNo;

  KartBilgi(
      {this.kartBakiye,
        this.sonYukleme,
        this.sonYuklemeTutar,
        this.kartTuru,
        this.sonHarcamaTutari,
        this.kartNo,
        this.ogrenciAd,
        this.ogrenciSoyad,
        this.tcNo,
        this.okulBolum,
        this.ogrenciNo});

  KartBilgi.fromJson(Map<String, dynamic> json) {
    kartBakiye = json['kartBakiye'];
    sonYukleme = json['sonYukleme'];
    sonYuklemeTutar = json['sonYuklemeTutarı'];
    kartTuru = json['kartTuru'];
    sonHarcamaTutari = json['sonHarcamaTutari'];
    kartNo = json['kartNo'];
    ogrenciAd = json['ogrenciAd'];
    ogrenciSoyad = json['ogrenciSoyad'];
    tcNo = json['tcNo'];
    okulBolum = json['okulBolum'];
    ogrenciNo = json['ogrenciNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kartBakiye'] = kartBakiye;
    data['sonYukleme'] = sonYukleme;
    data['sonYuklemeTutarı'] = sonYuklemeTutar;
    data['kartTuru'] = kartTuru;
    data['sonHarcamaTutari'] = sonHarcamaTutari;
    data['kartNo'] = kartNo;
    data['ogrenciAd'] = ogrenciAd;
    data['ogrenciSoyad'] = ogrenciSoyad;
    data['tcNo'] = tcNo;
    data['okulBolum'] = okulBolum;
    data['ogrenciNo'] = ogrenciNo;
    return data;
  }
}
