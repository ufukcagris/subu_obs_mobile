import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/models/yemek_menu.dart';
import 'package:son_drawer_zoom/pages/yardim_sayfasi.dart';
import 'bildirim_sayfasi.dart';

class YemekMenuSayfasi extends StatefulWidget {
  const YemekMenuSayfasi({Key? key}) : super(key: key);

  @override
  State<YemekMenuSayfasi> createState() => _YemekMenuSayfasiState();
}

class _YemekMenuSayfasiState extends State<YemekMenuSayfasi> {
  late Future<List<YemekMenu>> yemekMenuFuture;

  Future<List<YemekMenu>> yemekOku() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/yemek_menu.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak okuyacak.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => YemekMenu.fromJson(e));

    /// Iterable'dan List<Lessons> tipinde liste oluştur.
    final readYemekMenu = List<YemekMenu>.from(iterable);

    /// Tüm sonuçları döndür.
    return readYemekMenu;
  }

  @override
  void initState() {
    super.initState();

    yemekMenuFuture = yemekOku();
  }

  int currentIndex = 0;
  var secilenSayfa = [const BildirimSayfasi(), const YardimSayfasi()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: const Text('Yemek Menüsü'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red.shade900,
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
            FutureBuilder<List<YemekMenu>>(
              future: yemekMenuFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<YemekMenu>> snapshot,
              ) {
                if (snapshot.hasData) {
                  final yemekMenu = snapshot.data!;
                  return buildYemekMenu(yemekMenu);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Text("Yemek Bilgisi Bulunamadı.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildYemekMenu(List<YemekMenu> yemekMenu) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Swiper(
      itemBuilder: (context, index) {
        final menu = yemekMenu[index];
        return Opacity(
          opacity: 0.98,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Card(
                  color: const Color(0xff001384),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${menu.gun}",
                          style: TextStyle(
                              fontSize: ekranGenisligi/15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const Divider(thickness: 2),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0, left: 20),
                            child: Text("Çorba:",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50.0, right: 20),
                            child: Text("${menu.corba}",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text("Ana Yemek:",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 20),
                            child: Text("${menu.anaYemek}",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text("Yan Yemek:",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 20),
                            child: Text("${menu.yanYemek}",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text("Garnitür:",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 20),
                            child: Text("${menu.garnitur}",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text("2. Ana Yemek:",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 20),
                            child: Text("${menu.ikinciAnaYemek}",
                                style: TextStyle(
                                    fontSize: ekranGenisligi/30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: Text(
                          "-------------",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
      layout: SwiperLayout.TINDER,
      itemWidth: ekranGenisligi / 0.9,
      itemHeight: ekranGenisligi / 0.8,
      curve: Curves.easeInQuad,
      autoplay: false,
      loop: true,
      itemCount: 5,
      pagination: const SwiperPagination(builder: SwiperPagination.dots),
      control: const SwiperControl(color: Colors.red),
    );
  }
}
