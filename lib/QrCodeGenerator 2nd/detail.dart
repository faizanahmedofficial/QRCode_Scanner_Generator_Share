import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

class DetailWidget extends StatefulWidget  {

  final String _filePath;
  const DetailWidget(this._filePath, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }

}

class _DetailState extends State<DetailWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {

                const channel = MethodChannel('channel:me.alfian.share/share');
                channel.invokeMethod('shareFile', 'image.png');

              },
            )

          ],
        ),
        body: SizedBox(
          height: 500.0,
          child: Center(
              child: widget._filePath == null
                  ? const Text('No Image')
                  : SizedBox(
                  child: Image.file(File(widget._filePath), fit: BoxFit.fitWidth))
          ),
        )
    );

  }

}