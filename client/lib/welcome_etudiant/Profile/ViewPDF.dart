
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdf extends StatefulWidget {
  
  String url;
  ViewPdf(this.url);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  late PdfViewerController _pdfViewerController;
  bool circular=true;
  @override
  void initState(){
    _pdfViewerController = PdfViewerController();
  }

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SfPdfViewer.network(widget.url,
      controller: _pdfViewerController,
      )
    );
  }

}
