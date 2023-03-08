import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/pages/yardim_sayfasi.dart';
import 'package:son_drawer_zoom/pages/bildirim_sayfasi.dart';
import '../models/dersler.dart';
import '../models/menu_widget.dart';

class TranskriptSayfasi extends StatefulWidget {
  const TranskriptSayfasi({Key? key}) : super(key: key);

  @override
  State<TranskriptSayfasi> createState() => _TranskriptSayfasiState();
}

class _TranskriptSayfasiState extends State<TranskriptSayfasi> {
  late Future<List<Dersler>> derslerFuture;

  Future<List<Dersler>> dersOku() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/dersler.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak okuyacak.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => Dersler.fromJson(e));

    /// Iterable'dan List<Lessons> tipinde liste oluştur.
    final readDersler = List<Dersler>.from(iterable);

    /// Tüm sonuçları döndür.
    return readDersler;
  }

  @override
  void initState() {
    super.initState();

    derslerFuture = dersOku();
  }

  int currentIndex = 0;
  var secilenDersler = [
    const BildirimSayfasi(),
    const YardimSayfasi()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        leading: const MenuWidget(),
        backgroundColor: Colors.deepPurple,
        title: const Text('Transkript'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Bildirimler"),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              label: "Yardım"),
        ],
        currentIndex: currentIndex,
        onTap: (index){
          setState((){
            currentIndex = index;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> secilenDersler[index]));
          });
        },
      ),
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.asset("images/subu.png")),
            FutureBuilder<List<Dersler>>(
              future: derslerFuture,
              builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Dersler>> snapshot,
                  ) {
                if (snapshot.hasData) {
                  final dersler = snapshot.data!;
                  return buildDersler(dersler);
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

  Widget buildDersler(List<Dersler> dersler) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return ListView.builder(
      itemCount: dersler.length,
      itemBuilder: (context, index) {
        final ders = dersler[index];
        return Opacity(
          opacity: 0.8,
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            dividerColor: Colors.white,
            elevation: 1,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                body: Container(
                  padding: EdgeInsets.only(right: ekranGenisligi/8, left: ekranGenisligi/8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: ekranGenisligi/7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ders.puanStr,
                              textAlign: TextAlign.left,
                              style:  TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Spacer(flex: 2,),
                            Text(
                              ders.harfStr,
                              textAlign: TextAlign.left,
                              style:  TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      SizedBox(
                        height: ekranGenisligi/7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ders.puan,
                              style:  TextStyle(
                                  fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(flex: 2,),
                            Text(
                              ders.harfNotu,
                              style:  TextStyle(
                                  fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Text(
                          ders.dersKodu,
                          style:  TextStyle(
                              fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                            right: ekranGenisligi/8,
                          ),
                          child: SizedBox(
                            width: ekranGenisligi/2.3,
                            height: ekranGenisligi/20,
                            child: Text(
                              ders.dersAdi,
                              style:  TextStyle(
                                  fontSize: ekranGenisligi/28, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                isExpanded: ders.expanded,
              )
            ],
            expansionCallback: (int index, bool expanded) {
              setState(() {
                ders.expanded = !ders.expanded;
              });
            },
          ),
        );
      });
  }
}
