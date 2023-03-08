import 'package:flutter/material.dart';

class BildirimSayfasi extends StatefulWidget {
  const BildirimSayfasi({Key? key}) : super(key: key);

  @override
  State<BildirimSayfasi> createState() => _BildirimSayfasiState();
}

class _BildirimSayfasiState extends State<BildirimSayfasi> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirimler"),
        centerTitle: true,
        backgroundColor: Colors.green.shade900,
        ),
      body: Stack(
        children: [
          SizedBox(
            width: ekranGenisligi/1,
            child: Align(
                alignment: Alignment.center,
                child: Image.asset("images/subu.png",color: const Color.fromRGBO(255, 255, 255, 0.15),
                    colorBlendMode: BlendMode.modulate)
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children:   const [
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 2,
                    leading: Icon(Icons.school,color: Colors.orange,),
                    title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                    subtitle: Text("Mobil Programlama final notu: 100",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 2,
                      leading: Icon(Icons.school,color: Colors.orange,),
                      title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                      subtitle: Text("Yapay Zeka final notu: 70",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.message,color: Colors.green,),
                      title: Text("Mesaj",style: TextStyle(color: Colors.green,fontSize: 14),),
                      subtitle: Text("Dr. Öğr. Uyesi Bilal USANMAZ size mesaj gönderdi.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.school,color: Colors.orange,),
                      title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                      subtitle: Text("Sayısal Tasarım final notu: 85",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.message,color: Colors.green,),
                      title: Text("Mesaj",style: TextStyle(color: Colors.green,fontSize: 14),),
                      subtitle: Text("Dr. Öğr. Uyesi F. Baturalp GÜNAY size mesaj gönderdi.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.school,color: Colors.orange,),
                      title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                      subtitle: Text("Mobil Programlama 2. Ödev notu: 100",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.school,color: Colors.orange,),
                      title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                      subtitle: Text("Paralel Programlama final notu: 70",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.school,color: Colors.orange,),
                      title: Text("Not İlanı",style: TextStyle(color: Colors.orange,fontSize: 14),),
                      subtitle: Text("Paralel Programlama 2. Ödev notu: 65",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
                Divider(thickness: 1.5,),
                Padding(
                  padding: EdgeInsets.only(top: 1.0,bottom: 10),
                  child: ListTile(
                      dense: true,
                      horizontalTitleGap: 2,
                      leading: Icon(Icons.message,color: Colors.green,),
                      title: Text("Mesaj",style: TextStyle(color: Colors.green,fontSize: 14),),
                      subtitle: Text("Dr. Öğr. Uyesi Deniz DAL size mesaj gönderdi.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
