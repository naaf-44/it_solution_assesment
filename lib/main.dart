import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:it_solution_assesment/get_size.dart';
import 'package:it_solution_assesment/html_image_element_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Solution',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'IT Solution'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _urlController = TextEditingController();
  String? _imageUrl;
  bool _isContextMenuVisible = false;
  bool _isFullscreen = false;

  /// Show context menu
  void _toggleContextMenu() {
    setState(() {
      _isContextMenuVisible = !_isContextMenuVisible;
    });
  }

  /// Handle fullscreen toggle
  void _toggleFullscreen(bool isFullScreen) {
    setState(() {
      _isFullscreen = isFullScreen;
    });
    _toggleContextMenu();

    if (_isFullscreen) {
      /// Use JS functions to enter fullscreen
      html.document.body?.requestFullscreen();
    } else {
      /// Use JS functions to exit fullscreen
      html.document.exitFullscreen();
    }
  }

  /// Handle image double click to toggle fullscreen
  void _onImageDoubleClick() {
    if (_isFullscreen) {
      html.document.exitFullscreen();
    } else {
      html.document.body?.requestFullscreen();
    }

    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }

  /// Close the context menu if clicked outside
  void _closeContextMenu() {
    if (_isContextMenuVisible) {
      setState(() {
        _isContextMenuVisible = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: _closeContextMenu,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Opacity(
                opacity: _isContextMenuVisible? 0.3 : 1, /// handle opacity if the context menu is shown
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if(_imageUrl != null) /// display image only when the imageUrl is available
                      SizedBox(
                        height: GetSize.isDesktop(context) ? GetSize.height(context) * 0.5 : 200,
                        width: GetSize.isDesktop(context) ? GetSize.height(context) * 0.5 : 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onDoubleTap: _onImageDoubleClick, /// invoke double tap event on the image
                            child: HtmlImageElementView(imageUrl: _imageUrl), /// call HtmlImageElementView to display the image
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        /// TextFormField to enter the image url
                        Expanded(
                          child: TextFormField(
                            controller: _urlController,
                            decoration: InputDecoration(
                              label: Text("Image URL")
                            ),
                            keyboardType: TextInputType.url, /// set keyboard type url
                            onFieldSubmitted: (val) {
                              /// once submitted show the image
                              setState(() {
                                _imageUrl = val;
                              });
                            },
                            onChanged: (val) {
                              /// if the input is empty hide the image
                              if(val.isEmpty) {
                                setState(() {
                                  _imageUrl = null;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        /// button to show the image
                        ElevatedButton(onPressed: () {
                          /// display image when the button is clicked
                          /// check the condition if the url is not empty
                          if(_urlController.text.isNotEmpty) {
                            setState(() {
                              _imageUrl = _urlController.text;
                            });
                          }
                        }, child: Icon(Icons.arrow_forward_rounded, size: 40, color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /// floating action button
      floatingActionButton: Stack(
        children: [
          /// if _isContextMenuVisible is true show enter fullscreen and exit fullscreen button
          if(_isContextMenuVisible)
            Positioned(
              bottom: 80.0,
              right: 20.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: TextButton(onPressed: (){_toggleFullscreen(false);}, child: Text("Exit Fullscreen", style: TextStyle(color: Colors.white))),
              ),
            ),
          if(_isContextMenuVisible)
            Positioned(
            bottom: 140.0,
            right: 20.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: TextButton(onPressed: () {
                _toggleFullscreen(true);
              }, child: Text("Enter Fullscreen", style: TextStyle(color: Colors.white))),
            ),
          ),
          /// once the + button is clicked disable the floating button and enable enter and exit fullscreen button.
          if(!_isContextMenuVisible)
            Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: _toggleContextMenu,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
