import 'package:em_school/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

import '../../../common/models/entertainment_model.dart';

class OpenPdfFileScreen extends StatefulWidget {
  final EntertainmentModel model;

  const OpenPdfFileScreen({super.key, required this.model});


  @override
  State<OpenPdfFileScreen> createState() => _OpenPdfFileScreenState();
}

class _OpenPdfFileScreenState extends State<OpenPdfFileScreen> {
  late File pdFile;
  bool isLoading = false;

  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.model.link;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      pdFile = file;
    });

    print(pdFile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          widget.model.nameAr,
          style: TextStyles.textStyleFontBold20White,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
            child: PDFView(
              filePath: pdFile.path,
            ),
          ),
    );
  }
}
