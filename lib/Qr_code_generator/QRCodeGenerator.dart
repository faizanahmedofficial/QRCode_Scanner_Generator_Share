import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class QRCodePlayground extends StatefulWidget {
  const QRCodePlayground({super.key});

  @override
  _QRCodePlaygroundState createState() => _QRCodePlaygroundState();
}

class _QRCodePlaygroundState extends State<QRCodePlayground> {
  ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController tfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator and Share'),
        titleSpacing: 0.1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              if (tfController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Generate your QR code first')));
              } else {
                _shareQrCode();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: tfController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () => setState(() {}),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text('Generate QR Code'),
                ),
              ),
              const SizedBox(height: 200),
              tfController.text.isEmpty
                  ? const SizedBox.shrink()
                  : Screenshot(
                  controller: screenshotController,
                  child: QrImage(
                    size: 200,
                      backgroundColor: Colors.greenAccent,
                      data: tfController.text)),
            ],
          ),
        ),
      ),
    );
  }

  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final imageFile = await File('$directory/$fileName.png').create();
    screenshotController.capture().then((Uint8List image) async {
      if (image != null) {
        try {
          if (imageFile != null) {
            await imageFile.writeAsBytes(image);
            Share.shareFiles([imageFile.path]);
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}
