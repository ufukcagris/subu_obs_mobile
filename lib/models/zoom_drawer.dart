import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../pages/notlar_sayfasi.dart';
import '../pages/profil_sayfasi.dart';
import '../pages/transkript_sayfasi.dart';
import 'menu_item.dart';
import 'menu_sayfasi.dart';

class ZoomDrw extends StatefulWidget {
  const ZoomDrw({Key? key}) : super(key: key);

  @override
  State<ZoomDrw> createState() => _ZoomDrwState();
}

class _ZoomDrwState extends State<ZoomDrw> {
  MenuOge currentItem = MenuItems.profil;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      angle: 0,
      showShadow: true,
      shadowLayer1Color: Colors.black26,
      shadowLayer2Color: Colors.white54,
      mainScreenScale: 0.2,
      menuScreenWidth: MediaQuery.of(context).size.width*1,
      mainScreenTapClose: true,
      menuBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width*0.65,
      borderRadius: 40,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.decelerate,
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) => MenuSayfasi(
          currentItem: currentItem,
          onSelectedItem: (item){
            setState(() => currentItem = item);

            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
    );
  }
  Widget getScreen(){
    switch(currentItem){
      case MenuItems.profil:
        return const ProfilSayfasi();
      case MenuItems.notlar:
        return const NotlarSayfasi();
      case MenuItems.transkript:
        return const TranskriptSayfasi();
      case MenuItems.cikis:
        return exit(1);
      default:
        return const ProfilSayfasi();

    }
  }

}
