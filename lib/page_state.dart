import 'package:flutter/material.dart';
import 'package:image_search_app/image_search-page.dart';
import 'package:image_search_app/video_search_page.dart';

class PageState extends StatefulWidget {
  @override
  State<PageState> createState() => _PageStateState();
}

class _PageStateState extends State<PageState> {
  int _selectedIndex = 0;
  final _pages = [
    const ImageSearchApp(),
    const VideoSearchPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image_outlined),
            label: '이미지 검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: '비디오 검색',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
