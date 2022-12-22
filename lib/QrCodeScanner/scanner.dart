// import 'package:barcode_scan/gen/protos/protos.pbserver.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';
//
// import 'package:qr_flutter/qr_flutter.dart';
//
// class Scanner extends StatefulWidget {
//   @override
//   _ScannerState createState() => _ScannerState();
// }
//
// class _ScannerState extends State<Scanner> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("QR Scanner"),
//       ),
//       body: Center(
//         child: Text(
//           result,
//           style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(Icons.camera_alt),
//         label: Text("Scan"),
//         onPressed: _scanQR,
//       ),
//     );
//   }
// }