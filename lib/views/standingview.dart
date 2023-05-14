import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:fidelway/model/APIRest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/local_storage_helper.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FidelWay Nouveaux client'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom Complet *',
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email  *',
                ),
              )
            ]),
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow,
                    backgroundColor: Colors.black,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: Text(" Créer "),
                  onPressed: () {
                    print(LocalStorageHelper.readShopName());

                    setState(() {
                      _dataString = (LocalStorageHelper.readShopName() == null
                              ? "shop_"
                              : LocalStorageHelper.readShopName()) +
                          DateTime.now().microsecondsSinceEpoch.toString();
                      print(_dataString);
                      APIRest.create(_dataString, _nameController.text,
                              _telController.text)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Bien Créer"),
                        ));
                      });

                      _inputErrorText = null;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow,
                    backgroundColor: Colors.black,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  child: Text("Enregistrer"),
                  onPressed: () {
                    setState(() {
                      FlutterBarcodeScanner.scanBarcode(
                              "#000000", "Sortir", true, ScanMode.QR)
                          .then((code) {
                        if (code != "-1") {
                          APIRest.create(code, _nameController.text,
                                  _telController.text)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Bien Enregistrer"),
                            ));
                          });
                        }
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (_dataString.isNotEmpty)
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: _dataString,
                    size: 0.5 * bodyHeight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
