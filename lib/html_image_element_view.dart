import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// stateless widget to display the image from url
/// need to pass the imageUrl
/// displays the image using HtmlElementView

class HtmlImageElementView extends StatelessWidget {
  final String? imageUrl;
  const HtmlImageElementView({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    String viewType = generateViewType(); /// call generateViewType
    ui.platformViewRegistry.registerViewFactory(viewType, (int _) => web.HTMLImageElement()..src = imageUrl!);
    return HtmlElementView(viewType: viewType);
  }

  /// generateViewType is a function which provides the unique viewTypeId for HtmlElementView
  String generateViewType() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
