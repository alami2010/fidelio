import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_constants.dart';
import '../utils/local_storage_helper.dart';
import 'TypeFidelWay.dart';
import 'moreviewAPropos.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key key}) : super(key: key);

  @override
  _MoreViewState createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            TConstants.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
/*              Image.asset(
                'images/worldcup.png',
                height: 160,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(
                        Icons.stadium,
                        color: MyColors.grey3,
                      ),
                      title: Text("Stadiums"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(
                        Icons.stadium,
                        color: MyColors.grey3,
                      ),
                      title: Text("Matches"),
                    ),
                  ),
                ),
              ),*/
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AProposPage()));
                    },
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(
                          Icons.shopping_bag,
                          color: MyColors.grey3,
                        ),
                        title: Text(LocalStorageHelper.readShopName()),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AProposPage()));
                    },
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(
                          Icons.info,
                          color: MyColors.grey3,
                        ),
                        title: Text("à propos"),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TypeFidelWay()));
                    },
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(
                          Icons.info,
                          color: MyColors.grey3,
                        ),
                        title: Text("type d'application"),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
