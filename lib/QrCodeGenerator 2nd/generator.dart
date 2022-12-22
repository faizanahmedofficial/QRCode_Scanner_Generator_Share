import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});


  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  final formkey = GlobalKey<FormState>();


  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = GlobalKey();
  String _dataString = "Hello from this QR";
  var _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.share),
        //     onPressed: _captureAndSharePng,
        //   )
        // ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      // final RenderObject? boundary = globalKey.currentContext?.findRenderObject() as RenderObject;
      // var image = await boundary?.toImage();
      var image;
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      const channel = MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  SingleChildScrollView(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child:  Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: _topSectionTopPadding,
                left: 20.0,
                right: 10.0,
                bottom: _topSectionBottomPadding,
              ),
              child:  SizedBox(
                height: _topSectionHeight,
                child:  Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Form(
                      key: formkey,
                      child: Expanded(
                        child:  TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't Be Empty";
                            } else {
                              return null;
                            }
                          },
                          controller: _textController,
                          decoration:  InputDecoration(
                            hintText: "Enter a custom message",
                            errorText: _inputErrorText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:  MaterialButton(
                        color: Colors.blue,
                        child:  const Text("SUBMIT",style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          setState((){
                            if (formkey.currentState!.validate()) {
                              _dataString = _textController.text;
                              _textController.clear();
                            }
                            // _inputErrorText = null;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 200,),
            Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  backgroundColor: Colors.greenAccent,
                  data: _dataString,
                  size: 200,
                  // onError: (ex) {
                  //   print("[QR] ERROR - $ex");
                  //   setState((){
                  //     _inputErrorText = "Error! Maybe your input value is too long?";
                  //   });
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

