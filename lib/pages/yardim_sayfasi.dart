import 'package:flutter/material.dart';

class YardimSayfasi extends StatefulWidget {
  const YardimSayfasi({Key? key}) : super(key: key);

  @override
  State<YardimSayfasi> createState() => _YardimSayfasiState();
}

class _YardimSayfasiState extends State<YardimSayfasi> {

  final mesaj = TextEditingController();
  final konu = TextEditingController();
  bool dogrulamaKonu = false;
  bool dogrulamaMesaj = false;

  @override
  void dispose() {
    konu.dispose();
    mesaj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
      backgroundColor: const Color(0xffb4b1b1),
      appBar: AppBar(
        title: const Text("Yardım"),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: ekranGenisligi/1,
              child: Image.asset("images/subu.png"),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 20, left: 20),
                  child: Opacity(
                    opacity: 0.9,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: konu,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          hintText: "Yardım Konu Başlığını Giriniz",
                          hintStyle:  TextStyle(color: Colors.white30,fontSize: ekranGenisligi/25),
                          labelText: "Konu",
                          labelStyle:  TextStyle(color: Colors.white,fontSize: ekranGenisligi/25),
                          errorText: dogrulamaKonu ? "Konu başlığı boş olamaz" : null,
                          errorStyle:  TextStyle(color: Colors.red, fontSize: ekranGenisligi/33, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                  child: SizedBox(
                    height: 200,
                    child: Opacity(
                      opacity: 0.9,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        controller: mesaj,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: "Mesajınızı giriniz",
                            hintStyle:  TextStyle(color: Colors.white30,fontSize: ekranGenisligi/25),
                            labelText: "Mesaj",
                            labelStyle:  TextStyle(color: Colors.white,fontSize: ekranGenisligi/25),
                            errorText: dogrulamaMesaj ? "Mesaj içeriği boş olamaz" : null,
                            errorStyle:  TextStyle(color: Colors.red, fontSize: ekranGenisligi/33, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900
                        ),
                        onPressed: () {
                          if(mesaj.text.isEmpty || konu.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Konu veya mesaj içeriği boş bırakılamaz!"))
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Mesajınız gönderildi. En kısa sürede dönüş sağlanacaktır."))
                            );
                          }
                          setState(() {
                            mesaj.text.isEmpty ? dogrulamaMesaj = true : dogrulamaMesaj = false;
                            konu.text.isEmpty ? dogrulamaKonu = true : dogrulamaKonu = false;
                          });
                        },
                        child: const Text("GÖNDER")),
                  ),
                )
              ],
            ),
          )


        ],
      ),
    );
  }
}
