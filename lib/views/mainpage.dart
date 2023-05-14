import 'package:after_layout/after_layout.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fidelway/styles/colors.dart';
import 'package:fidelway/styles/text_constants.dart';
import 'package:fidelway/views/standingview.dart';
import 'package:fidelway/views/predictionview.dart';
import 'package:fidelway/views/homeview.dart';
import 'package:fidelway/views/newsview.dart';
import 'package:fidelway/views/splash.dart';
import 'package:fidelway/views/moreview.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../utils/local_storage_helper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }



}


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin , AfterLayoutMixin {

  TabController controller;

  PersistentTabController _controller = PersistentTabController(initialIndex: 1);

  List<Widget> _buildScreens() {
    return [
      GenerateScreen(),
      HomeView(),
      MoreView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.news),
        title: ("Nouveau"),
        activeColorPrimary: MyColors.backgroundColor2,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "images/logo.png",
          width: 40,
        ),
        title: ("Scanner"),
        activeColorPrimary: MyColors.btnOk,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),

        activeColorPrimary: MyColors.backgroundColor2,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    controller.dispose();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }


  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    showHelloWorld();
  }

  void showHelloWorld() {
    var shopName = LocalStorageHelper.readShopName();
    final TextEditingController _nameController = TextEditingController();

    print(shopName);
    if (shopName == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          backgroundColor: Colors.grey,
          title: Column(
            children: [
              const Text(
                "Bienvenue sur FildeWay ?",
                style: TextStyle(color: Colors.white),
              ),
              const Text(
                "Veuillez entrer le nom de votre boutique",
                style: TextStyle(color: Colors.white),)
            ],
          ),
          content: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom Boutique *',
            ),
          ),
          actions: [

            TextButton(
                child: const Text("Valider",style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  Navigator.pop(context);
                  print(_nameController.text);
                  LocalStorageHelper.writeShopName(_nameController.text);

                }),
          ],
        ),
      );
    }
  }

}



