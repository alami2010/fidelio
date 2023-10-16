import 'package:carousel_pro/carousel_pro.dart';
import 'package:fidelway/styles/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../model/APIRest.dart';
import '../model/Client.dart';
import '../styles/colors.dart';
import '../utils/local_storage_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool notification = false;
  Client client = Client();

  void scanQrCode() {

     FlutterBarcodeScanner.scanBarcode("#000000", "Sortir", true, ScanMode.QR)
        .then((value) {

      if (value != "-1") {
        APIRest.scan(value).then((value) {
          setState(() {
            // adding a new marker to map
            client = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(client);

    var mode = LocalStorageHelper.readMode();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            TConstants.title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'QatarBold',
                color: MyColors.backgroundColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.backgroundColor),
                    child: Carousel(
                      borderRadius: true,
                      dotBgColor: Colors.transparent,
                      images: [
                        ExactAssetImage("images/fidelway-logo.png"),
                        ExactAssetImage("images/fidelway-logo.png"),
                        ExactAssetImage("images/fidelway-logo.png"),
                      ],
                    ),
                  )),
              Container(
                  height: 150,
                  margin: EdgeInsets.only(left: 7, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: MyColors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              scanQrCode();
                            },
                            child: Text('Scanner'))
                      ],
                    ),
                  )),
              if (client.code != null)
                Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 7, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: MyColors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Votre solde est :" + client.solde.toString(),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )),
              if (client.code != null)
                InkWell(
                  onTap: () => setState(() {
                    // adding a new marker to map
                    client = Client();
                  }),
                  child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 7, bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        color: MyColors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Déconnexion",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )),
                ),
              if (mode.isEmpty || mode == 1.toString())
                Row(
                  children: [
                    if (client.amounts != null)
                      for (int i = 0; i < client.amounts.length; i++)
                        InkWell(
                          onTap: () {
                            APIRest.minus(client.code, client.amounts[i])
                                .then((value) {
                              setState(() {
                                // adding a new marker to map
                                client = value;
                              });
                            });
                          },
                          child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.only(left: 7, bottom: 5),
                              child: Container(
                                color: MyColors.blue,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      client.amounts[i].toString() + ' €	',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )),
                        )
                  ],
                )
              else
                buildRow(mode),
              if (client.history != null)
                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Text(
                    'Historique des points',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              if (client.history != null)
                for (int i = 0; i < client.history.length; i++)
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: InkWell(
                          child: itemCard(
                              client.history[i].date, client.history[i].amout)),
                    ),
                  )
            ],
          ),
        ));
  }

  Row buildRow(String mode) {
    List<String> list = [];

    if (mode == 2.toString()) list = client.fastFoodRepas;
    if (mode == 3.toString()) list = client.pizza;
    if (mode == 4.toString()) list = client.coiffeur;

    return Row(
      children: [
        if (list != null)
          for (int i = 0; i < list.length; i++)
            InkWell(
              onTap: () {
                APIRest.minus(client.code, getAmount(list[i])).then((value) {
                  setState(() {
                    // adding a new marker to map
                    client = value;
                  });
                });
              },
              child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(left: 7, bottom: 5),
                  child: Container(
                    color: MyColors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          "images/" + list[i]+".png",
                          width: 40,
                        ),
                      ],
                    ),
                  )),
            )
      ],
    );
  }

  int getAmount(String repas) {
    if (repas == "coca") {
      return 5;
    } else if (repas == "burger") {
      return 10;
    } else if (repas == "menu") {
      return 15;
    } else if (repas == "coca_pizza") {
      return 3;
    } else if (repas == "pizza") {
      return 5;
    } else if (repas == "coiffeur") {
      return 6;
    }

    return 0;
  }

  Widget itemCard(String date, int point) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Container(
                  child: ListTile(
                leading: Text(
                  point.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                title: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
              )),
            ],
          )),
    );
  }
}
