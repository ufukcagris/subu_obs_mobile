import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:son_drawer_zoom/models/notlar.dart';
import 'package:son_drawer_zoom/pages/yardim_sayfasi.dart';
import 'package:son_drawer_zoom/pages/bildirim_sayfasi.dart';
import '../models/menu_widget.dart';

class NotlarSayfasi extends StatefulWidget {
  const NotlarSayfasi({Key? key}) : super(key: key);

  @override
  State<NotlarSayfasi> createState() => _NotlarSayfasiState();
}

class _NotlarSayfasiState extends State<NotlarSayfasi> {
  late Future<List<Notlar>> notlarFuture;

  Future<List<Notlar>> notGet() async {
    /// Okuma yapılacak olan dosyanın yolu
    const localPath = "assets/notlar.json";

    /// JSON Array[] olan dosyadaki ham veriyi [String] olarak okuyacak.
    final responseLocal = await rootBundle.loadString(localPath);

    /// Okunan ham veriyi decode ederek List'e dönüştür
    final List decoded = jsonDecode(responseLocal);

    /// Her bir elemanı parse et (JsonToDart) ve sonuçları iterable'a dönüştür
    final iterable = decoded.map((e) => Notlar.fromJson(e));

    /// Iterable'dan List<Lessons> tipinde liste oluştur.
    final readNotlar = List<Notlar>.from(iterable);

    /// Tüm sonuçları döndür.
    return readNotlar;
  }

  @override
  void initState() {
    super.initState();

    notlarFuture = notGet();
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
        backgroundColor: Colors.teal,
        title: const Text('Notlar'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.teal,
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
            Center(child: Image.asset("images/subu.png",)),
            FutureBuilder<List<Notlar>>(
              future: notlarFuture,
              builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Notlar>> snapshot,
                  ) {
                if (snapshot.hasData) {
                  final notlar = snapshot.data!;
                  return buildNotlar(notlar);
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

  Widget buildNotlar(List<Notlar> notlar) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return ListView.builder(
      itemCount: notlar.length,
      itemBuilder: (context, index) {
        final not = notlar[index];
        return Opacity(
          opacity: 0.8,
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            dividerColor: Colors.red,
            elevation: 1,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                body: Container(
                  padding: EdgeInsets.only(right: ekranGenisligi/8, left: ekranGenisligi/8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: ekranGenisligi/2.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              "1. Ödev:",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Divider(thickness: 1,),
                            Text(
                              "2. Ödev:",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Divider(thickness: 1,),
                            Text(
                              "Vize:",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Divider(thickness: 1,),
                            Text(
                              "Final:",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: ekranGenisligi/29),
                            ),
                            const Divider(thickness: 1,),
                            Text(
                              "Ortalama:",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: ekranGenisligi/23,fontWeight: FontWeight.bold, color: Colors.redAccent),
                            ),
                            const Divider(thickness: 1,),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: ekranGenisligi/50),
                        child: SizedBox(
                          height: ekranGenisligi/2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                not.odevBir,
                                style:  TextStyle(
                                    fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1,),
                              Text(
                                not.odevIki,
                                style:  TextStyle(
                                    fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1,),
                              Text(
                                not.vizeSinavi,
                                style:  TextStyle(
                                    fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1,),
                              Text(
                                not.finalSinavi,
                                style:  TextStyle(
                                    fontSize: ekranGenisligi/25, fontWeight: FontWeight.bold),
                              ),
                              const Divider(thickness: 1,),
                              Text(
                                not.toplamNot,
                                style:  TextStyle(
                                    fontSize: ekranGenisligi/21, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              ),
                              const Divider(thickness: 1,),
                            ],
                          ),
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
                          not.dersKodu,
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
                              not.dersAdi,
                              style:  TextStyle(
                                  fontSize: ekranGenisligi/28, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                isExpanded: not.expanded,
              ),
            ],
            expansionCallback: (int index, bool expanded) {
              setState(() {
                not.expanded = !not.expanded;
              });
            },
          ),
        );
      });
  }

}
