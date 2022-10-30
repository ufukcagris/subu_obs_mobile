import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/pages/yardim_sayfasi.dart';
import '../models/ders_prog.dart';
import 'bildirim_sayfasi.dart';

class DersProgramiSayfasi extends StatefulWidget {
  const DersProgramiSayfasi({Key? key}) : super(key: key);

  @override
  State<DersProgramiSayfasi> createState() => _DersProgramiSayfasiState();
}

class _DersProgramiSayfasiState extends State<DersProgramiSayfasi> {
  late Future<List<DersProg>> dersProgFuture;

  Future<List<DersProg>> dersOku() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/ders_programi.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak okuyacak.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => DersProg.fromJson(e));

    /// Iterable'dan List<Lessons> tipinde liste oluştur.
    final readDersProg = List<DersProg>.from(iterable);

    /// Tüm sonuçları döndür.
    return readDersProg;
  }

  @override
  void initState() {
    super.initState();

    dersProgFuture = dersOku();
  }

  int currentIndex = 0;
  var secilenSayfa = [const BildirimSayfasi(), const YardimSayfasi()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: const Text('Ders Programı'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade900,
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
            FutureBuilder<List<DersProg>>(
              future: dersProgFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<DersProg>> snapshot,
              ) {
                if (snapshot.hasData) {
                  final dersProg = snapshot.data!;
                  return buildDersProg(dersProg);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Text("Ders programı bilgisi bulunamadı.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDersProg(List<DersProg> dersProg) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Swiper(
      itemBuilder: (context, index) {
        final program = dersProg[index];
        return Opacity(
          opacity: 0.97,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Card(
                  color: Colors.lightGreen.shade900,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${program.gun}",
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const Divider(thickness: 2),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Kodu:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.dersKodu}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Adı:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.dersAdi}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Saati:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.dersSaati}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Eğitmen:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.ogretmen}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Derslik:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.derslik}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Grup:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${program.grup}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Kodu:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].dersKodu}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Adı:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].dersAdi}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Saati:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].dersSaati}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Eğitmen:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].ogretmen}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Derslik:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].derslik}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Grup:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 5].grup}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Kodu:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].dersKodu}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Adı:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].dersAdi}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Ders Saati:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].dersSaati}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Eğitmen:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].ogretmen}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Derslik:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].derslik}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 20),
                                child: Text("Grup:",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 20),
                                child: Text("${dersProg[index + 10].grup}",
                                    style: TextStyle(
                                        fontSize: ekranGenisligi / 27,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          const Text(
                            "-------------",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        );
      },
      curve: Curves.easeInQuad,
      layout: SwiperLayout.DEFAULT,
      itemWidth: ekranGenisligi/0.1,
      itemHeight: ekranYuksekligi/1.5,
      autoplay: false,
      loop: true,
      itemCount: 5,
      pagination: const SwiperPagination(builder: SwiperPagination.dots),
      control: const SwiperControl(color: Colors.deepPurple),
    );
  }
}
