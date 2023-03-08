import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:son_drawer_zoom/models/menu_widget.dart';
import 'package:son_drawer_zoom/models/ogrenci_bilgi.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/pages/ders_programi_sayfasi.dart';
import 'package:son_drawer_zoom/pages/kart_bilgi_sayfasi.dart';
import 'package:son_drawer_zoom/pages/yemek_menusu_sayfasi.dart';

class ProfilSayfasi extends StatefulWidget {
  const ProfilSayfasi({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasi> createState() => _ProfilSayfasiState();
}


class _ProfilSayfasiState extends State<ProfilSayfasi> {
  late Future<List<OgrenciBilgisi>> ogrenciFuture;

  Future<List<OgrenciBilgisi>> ogrenciBilgisiParse() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/profil.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak okuyacak.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => OgrenciBilgisi.fromJson(e));

    /// Iterable'dan List<OgrenciBilgisi> tipinde liste oluştur.
    final readOgrenci = List<OgrenciBilgisi>.from(iterable);

    /// Tüm sonuçları döndür.
    return readOgrenci;
  }

  @override
  void initState() {
    super.initState();
    ogrenciFuture = ogrenciBilgisiParse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.asset("images/subu.png",)),
            FutureBuilder<List<OgrenciBilgisi>>(
              future: ogrenciFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<OgrenciBilgisi>> snapshot,
              ) {
                if (snapshot.hasData) {
                  final ogrenciler = snapshot.data!;
                  return buildOgrenci(ogrenciler);
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Text("Ders bilgisi bulunamadı.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOgrenci(List<OgrenciBilgisi> ogrenciler) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    final ogrenci = ogrenciler[0];
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent.withOpacity(0.8),
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const MenuWidget(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: CircleAvatar(
                    radius: ekranGenisligi/6.6,
                    backgroundColor: Colors.blueGrey,
                    child: SizedBox(
                      height: ekranGenisligi/3.5,
                      width: ekranGenisligi/3.5,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: ogrenci.userImage.toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, imageUrl) => const CircularProgressIndicator(),
                          errorWidget: (context, imageUrl, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Text(
                        "${ogrenci.isimSoyisim}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      Text(
                        "${ogrenci.ogrNo}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      Text(
                        "${ogrenci.ogrBolum}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: ekranGenisligi/1.4,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade900,
                                elevation: 50,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.indigo.shade900,width: 2),
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DersProgramiSayfasi()));
                              },
                              child: const Text("Ders Programı")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: ekranGenisligi/1.4,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900,
                                elevation: 50,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const YemekMenuSayfasi()));
                              },
                              child: const Text("Yemek Menüsü")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 50),
                        child: SizedBox(
                          width: ekranGenisligi/1.4,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900,
                                elevation: 50,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.indigo.shade900,width: 2),
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const KartBilgiSayfasi()));
                              },
                              child: const Text("Kart Bakiyesi")),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }
}
