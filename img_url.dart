import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  String? imageUrl;
  bool isMenuOpen = false;
  bool isFullscreen = false;

  void _toggleFullScreen() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullscreen ? null : AppBar(title: const Text('Flutter Demo')),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.purple.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: _toggleFullScreen,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: imageUrl != null
                          ? Image.network(imageUrl!, fit: BoxFit.cover)
                          : const Center(child: Text("Enter URL & Click →")),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          hintText: 'Image URL',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          imageUrl = _urlController.text;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          if (isMenuOpen)
            GestureDetector(
              onTap: () => setState(() => isMenuOpen = false),
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Positioned(
            bottom: 80,
            right: 20,
            child: isMenuOpen
                ? Column(
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          _toggleFullScreen();
                          setState(() => isMenuOpen = false);
                        },
                        label: const Text("Enter Fullscreen"),
                        icon: const Icon(Icons.fullscreen),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            isFullscreen = false;
                          });
                          setState(() => isMenuOpen = false);
                        },
                        label: const Text("Exit Fullscreen"),
                        icon: const Icon(Icons.fullscreen_exit),
                      ),
                    ],
                  )
                : Container(),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => setState(() => isMenuOpen = !isMenuOpen),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: isFullscreen,
    );
  }
}
