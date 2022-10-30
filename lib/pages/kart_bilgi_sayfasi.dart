import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/models/kartBilgi.dart';
import 'package:son_drawer_zoom/pages/yardim_sayfasi.dart';
import 'bildirim_sayfasi.dart';

class KartBilgiSayfasi extends StatefulWidget {
  const KartBilgiSayfasi({Key? key}) : super(key: key);

  @override
  State<KartBilgiSayfasi> createState() => _KartBilgiSayfasiState();
}

class _KartBilgiSayfasiState extends State<KartBilgiSayfasi> {
  late Future<List<KartBilgi>> kartBilgiFuture;

  Future<List<KartBilgi>> kartOku() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/kart_bilgi.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak oku.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => KartBilgi.fromJson(e));

    /// Iterable'dan List<KartBilgi> tipinde liste oluştur.
    final readKartBilgisi = List<KartBilgi>.from(iterable);

    /// Tüm sonuçları döndür.
    return readKartBilgisi;
  }

  @override
  void initState() {
    super.initState();

    kartBilgiFuture = kartOku();
  }

  int currentIndex = 0;
  var secilenSayfa = [const BildirimSayfasi(), const YardimSayfasi()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Kart Bakiye'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Bildirimler"),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline), label: "Yardım"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => secilenSayfa[index]));
          });
        },
      ),
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.asset("images/subu.png")),
            FutureBuilder<List<KartBilgi>>(
              future: kartBilgiFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<KartBilgi>> snapshot,
              ) {
                if (snapshot.hasData) {
                  final kartBilgisi = snapshot.data!;
                  return buildKartBilgisi(kartBilgisi);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Text("Kart Bilgisi Bulunamadı.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKartBilgisi(List<KartBilgi> kartBilgi) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Builder(builder: (context) {
      final kart = kartBilgi[0];
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Card(
                    elevation: 10.0,
                    color: const Color(0x00000000),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      fill: Fill.fillBack,
                      front: Container(
                        height: ekranGenisligi/1.9,
                        width: ekranGenisligi/1.1,
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 15, bottom: 20),
                                          child: SizedBox(
                                              height: ekranGenisligi/6,
                                              width: ekranGenisligi/6,
                                              child: Image.asset("images/subu.png"))),
                                      Container(
                                          margin: const EdgeInsets.only(bottom: 10, left: 15),
                                          child: SizedBox(
                                              height: ekranGenisligi/6,
                                              width: ekranGenisligi/6,
                                              child: ClipOval(
                                                  child: Image.asset(
                                                      "images/profil_foto.jpg")))),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin:  EdgeInsets.only(top: 5,bottom: 5, left: ekranGenisligi/15),
                                          child:  Text(
                                            "Sakarya Uygulamalı Bilimler \n               Üniversitesi",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: ekranGenisligi/30,
                                                color: const Color(0xff264695)),
                                          )),
                                      Container(
                                          margin:
                                               EdgeInsets.only(bottom: 2, top: 2, left: ekranGenisligi/15),
                                          child:  Text("Mühendislik Fakültesi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ekranGenisligi/35,
                                                  color: const Color(0xff264695)))),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 2,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Kart Bakiyesi                  : ${kart.kartBakiye} TL",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              const Divider(
                                                thickness: 2,
                                                color: Colors.black,
                                                height: 0.1,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 2,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Son Yükleme Tarihi       : ${kart.sonYukleme}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 2,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Son Yükleme Tutarı       : ${kart.sonYuklemeTutar} TL",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 2,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Son Harcama Tutarı      : ${kart.sonHarcamaTutari} TL",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 10,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Kart No                            : ${kart.kartNo}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      back: Container(
                        height: ekranGenisligi/2.0,
                        width: ekranGenisligi/1.2,
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, left: 15, bottom: 20),
                                          child: SizedBox(
                                              height: ekranGenisligi/6,
                                              width: ekranGenisligi/6,
                                              child: Image.asset("images/subu.png"))),
                                      Container(
                                          margin: const EdgeInsets.only(bottom: 10, left: 15),
                                          child: SizedBox(
                                              height: ekranGenisligi/6,
                                              width: ekranGenisligi/6,
                                              child: ClipOval(
                                                  child: Image.asset(
                                                      "images/profil_foto.jpg")))),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          margin:  EdgeInsets.only(top: 5,bottom: 5, right: ekranGenisligi/20),
                                          child:  Text(
                                            "Sakarya Uygulamalı Bilimler \n               Üniversitesi",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: ekranGenisligi/30,
                                                color: const Color(0xff264695)),
                                          )),
                                      Container(
                                          margin:
                                          EdgeInsets.only(bottom: 2, top: 2, right: ekranGenisligi/20),
                                          child:  Text("Mühendislik Fakültesi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ekranGenisligi/35,
                                                  color: const Color(0xff264695)))),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 2,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Öğrenci Adı            : ${kart.ogrenciAd}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              const Divider(
                                                thickness: 2,
                                                color: Colors.black,
                                                height: 0.1,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 2, right: 1, left: 15),
                                                child: Text(
                                                    "Öğrenci Soyadı      : ${kart.ogrenciSoyad}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 2, right: 1, left: 15),
                                                child: Text(
                                                    "Öğrenci No             : ${kart.ogrenciNo}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 2, right: 1, left: 15),
                                                child: Text(
                                                    "TC Kimlik No          : ${kart.tcNo}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 10,
                                                    right: 1,
                                                    left: 15),
                                                child: Text(
                                                    "Bölümü                    : ${kart.okulBolum}",
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: ekranGenisligi/34,
                                                        color: const Color(0xff000000))),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
