import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// A professional PDF viewer widget for Flutter
/// Uses [flutter_pdfview] internally
class PdfView extends StatefulWidget {
  /// The URL of the PDF to display
  final String pdfUrl;

  /// Title to display on the AppBar
  final String title;

  /// AppBar background color
  final Color appBarColor;

  /// AppBar foreground color
  final Color appBarForeground;

  const PdfView({
    super.key,
    required this.pdfUrl,
    this.title = 'PDF Document',
    this.appBarColor = Colors.black,
    this.appBarForeground = Colors.white,
  });

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String? pdfPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  /// Download PDF from URL and store locally
  Future<void> _loadPdf() async {
    try {
      final file = await _downloadPdf(widget.pdfUrl);
      setState(() {
        pdfPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('PDF load error: $e');
    }
  }

  /// Download PDF and return local File
  Future<File> _downloadPdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${url.split('/').last}');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.title.tr),
        backgroundColor: widget.appBarColor,
        foregroundColor: widget.appBarForeground,
      ),
      body: Obx(() {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (pdfPath != null) {
          return PDFView(
            filePath: pdfPath!,
            enableSwipe: true,
            fitEachPage: true,
            autoSpacing: false,
            pageFling: false,
            onError: (error) => debugPrint('PDF error: $error'),
            onPageError: (page, error) =>
                debugPrint('PDF page $page error: $error'),
          );
        } else {
          return const Center(child: Text('Failed to load PDF'));
        }
      }),
    );
  }
}
