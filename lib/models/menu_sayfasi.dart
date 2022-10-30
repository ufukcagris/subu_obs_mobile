import 'package:flutter/material.dart';
import 'package:son_drawer_zoom/models/menu_item.dart';

class MenuItems {
  static const profil = MenuOge("Profil", Icons.account_circle_rounded);
  static const ogrenim = MenuOge("Öğrenim", Icons.school);
  static const notlar = MenuOge("Notlar", Icons.check);
  static const transkript = MenuOge("Transkript", Icons.fact_check);
  static const cikis = MenuOge("Çıkış", Icons.exit_to_app);

  static const all = <MenuOge>[
    profil,
    ogrenim,
    notlar,
    transkript,
    cikis,
  ];
}

class MenuSayfasi extends StatelessWidget {
  final MenuOge currentItem;
  final ValueChanged<MenuOge> onSelectedItem;


  const MenuSayfasi({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          alignment: const Alignment(-0.50,0),
                          child: SizedBox(
                              width: ekranGenisligi/5,
                              height: ekranGenisligi/5,
                              child: ClipOval(child: Image.asset("images/profil_foto.jpg",fit: BoxFit.fill,))),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Container(
                          alignment: const Alignment(-0.53,0),
                          child:  Text("Ufuk Çağrı SUCU",style: TextStyle(fontWeight: FontWeight.bold,fontSize: ekranGenisligi/30),)),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                ...MenuItems.all.map(buildMenuItem).toList(),
                Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:ekranGenisligi/9, top: 10),
                          child: SizedBox(
                            height: ekranYuksekligi/9,
                            width: ekranGenisligi/3,
                            child: Image.asset("images/motto.png"),

                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: ekranGenisligi/7, top: 60, bottom: 20),
                          child: SizedBox(
                            height: ekranYuksekligi/4,
                            width: ekranGenisligi/4,
                            child: Image.asset("images/subu.png"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildMenuItem(MenuOge item){

    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selectedTileColor: Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: (){
          return onSelectedItem(item);
        },
      ),
    );
  }
}

