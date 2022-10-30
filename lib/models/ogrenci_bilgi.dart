class OgrenciBilgisi {
  String? userImage;
  String? ogrNo;
  String? isimSoyisim;
  String? ogrBolum;

  OgrenciBilgisi({this.userImage, this.ogrNo, this.isimSoyisim, this.ogrBolum});

  OgrenciBilgisi.fromJson(Map<String, dynamic> json) {
    userImage = json['userImage'];
    ogrNo = json['ogrNo'];
    isimSoyisim = json['isimSoyisim'];
    ogrBolum = json['ogrBolum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userImage'] = userImage;
    data['ogrNo'] = ogrNo;
    data['isimSoyisim'] = isimSoyisim;
    data['ogrBolum'] = ogrBolum;
    return data;
  }
}
