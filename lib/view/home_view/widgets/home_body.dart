import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:t1t1/view/home_view/widgets/temp_screen.dart';
import 'package:t1t1/view_model/home_view_model.dart';
import 'package:epub_view/epub_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context
        .select((HomeViewModel homeViewModel) => homeViewModel.isLoading);
    List<EpubBook> epubListBook = context.read<HomeViewModel>().epubListBook;
    return !isLoading
        ? GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return _ItemBody(index: index);
            },
            itemCount: epubListBook.length,
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.green,
          ));
  }
}

class _ItemBody extends StatefulWidget {
  const _ItemBody({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<_ItemBody> createState() => _ItemBodyState();
}

class _ItemBodyState extends State<_ItemBody> {
  List<EpubByteContentFile>? epubByteContentFile;
  List? images;
  String? generatedPdfFilePath;
  File? pdfFile;


  @override
  void initState() {
    super.initState();

    HomeViewModel.tempText="";

    epubByteContentFile = context
        .read<HomeViewModel>()
        .epubListBook[widget.index]
        .Content
        ?.Images
        ?.values
        .toList();
    images = epubByteContentFile?.map((e) => e.Content).toList();



  }

  Future<void> generateExampleDocument(String htmlContent) async {
/*
    final htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>

        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>

        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;
*/

    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(htmlContent, targetPath, targetFileName);
    pdfFile = generatedPdfFile;
    generatedPdfFilePath = generatedPdfFile.path;
  }

  /*Future<void> openEpub() async {
    EpubViewer.setConfig(
      themeColor: Colors.green,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.HORIZONTAL,
      allowSharing: true,
    );

    // EpubViewer.locatorStream.listen((locator) {
    //   print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
    // });
    // EpubViewer.open('/storage/emulated/0/Download/1.epub');
    await EpubViewer.openAsset(
      context.read<HomeViewModel>().epubsPath[widget.index].toString(),
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }
*/
  Future<void> openEpub2() async {

    print('sssssss');
    /*print(context.read<HomeViewModel>()
        .epubListBook[widget.index].Content!.Css!.values.first.Content);
    */print('sssssss');




    HomeViewModel.tempText=context.read<HomeViewModel>()
        .epubListBook[widget.index].Content!.Html!.values.first.Content.toString();


    HomeViewModel.tempText=context.read<HomeViewModel>()
        .epubListBook[widget.index].Chapters!.first.HtmlContent.toString();
    HomeViewModel.cssText=context.read<HomeViewModel>()
        .epubListBook[widget.index].Content!.Css!.values.first.Content.toString();




    await generateExampleDocument(HomeViewModel.tempText);

/*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          PDFViewerScaffold(
              appBar: AppBar(title: Text("Generated PDF Document")),
              path: generatedPdfFilePath,
          )),
    );*/

    HomeViewModel.pdfPath = pdfFile!;

    print('object');
    print(HomeViewModel.pdfPath );
    print('object');

     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TempScreen()),
    );






  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openEpub2();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54,
            image: images == null
                ? null
                : DecorationImage(
                    fit: BoxFit.fill,
                    image: MemoryImage(Uint8List.fromList(
                        images?.length == 1 ? images![0] : images![1])))),
      ),
    );
  }
}
