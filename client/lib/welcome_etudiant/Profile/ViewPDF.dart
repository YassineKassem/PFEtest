
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class ViewPDF extends StatelessWidget {
  String pathPDF;
  ViewPDF({required this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold( //view PDF 
        appBar: AppBar(
          title: Text("Document"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        path: pathPDF
    );
  }
}