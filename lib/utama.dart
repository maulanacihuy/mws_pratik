import 'package:flutter/material.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _images = [
    'assets/profile.png',
    'assets/profile.png',
    'assets/profile.png',
    'assets/profile.png',
  ];

  late final PageController _imageController;
  late final Timer _imageTimer;
  int _imagePage = 100;

  @override
  void initState() {
    super.initState();
    _imageController = PageController(
      initialPage: _imagePage,
      viewportFraction: 0.82,
    );
    _imageTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _imagePage++;
      _imageController.animateToPage(
        _imagePage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _imageTimer.cancel();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Utama'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'SELAMAT DATANG!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 170,
              child: PageView.builder(
                key: const ValueKey('imageCarousel'),
                controller: _imageController,
                itemBuilder: (context, index) {
                  final imageIndex = index % _images.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(_images[imageIndex], fit: BoxFit.cover),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              color: Colors.black54,
                              child: Text(
                                'Gambar ${imageIndex + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      key: const ValueKey('innerContentList'),
                      padding: const EdgeInsets.all(12),
                      itemCount: 10,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(title: Text('Konten ${index + 1}')),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
