import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:t1t1/view/home_view/home_view.dart';
import 'package:t1t1/view/home_view/widgets/home_body.dart';

import '../../../view_model/home_view_model.dart';

class TempScreen extends StatelessWidget{
  static String rout = 'temp';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return

  /*    Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HomeView()),
        );
      },
      icon: Icon(Icons.back_hand),),),
      body:
    SingleChildScrollView(
      child: Html(
      data: HomeViewModel.tempText,
        onLinkTap: (url, _, __, ___) {
          print("Opening $url...");
        },
        onImageTap: (src, _, __, ___) {
          print(src);
        },
        onImageError: (exception, stackTrace) {
          print(exception);
        },
        onCssParseError: (css, messages) {
          print("css that errored: $css");
          print("error messages:");
          messages.forEach((element) {
            print(element);
          });
        },
        shrinkWrap: true,

        ),
    )



    // SingleChildScrollView(child: Text(HomeViewModel.tempText,textAlign: TextAlign.center,)),
    );
  */

      Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter PDF Viewer'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body:Directionality(
          textDirection: TextDirection.rtl,
          child:
          SfPdfViewer.file(
          HomeViewModel.pdfPath!,
          key: _pdfViewerKey,
            scrollDirection: PdfScrollDirection.horizontal,
        ),),

       /* SfPdfViewer.network(
          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
          key: _pdfViewerKey,
        ),*/
      );

  }

}