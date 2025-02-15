import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class HtmlImageElementView extends StatelessWidget {
  final String? imageUrl;
  const HtmlImageElementView({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    String viewType = generateViewType();
    ui.platformViewRegistry.registerViewFactory(viewType, (int _) => web.HTMLImageElement()..src = imageUrl!);
    return HtmlElementView(viewType: viewType);
  }

  String generateViewType() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
