import 'package:flutter/material.dart';
import 'package:goflix/pages/search_screen.dart';

AppBar searchWidget(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.bottomCenter,
          color: Colors.grey.withOpacity(1.0),
          child: Center(
            child: TextField(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              decoration: const InputDecoration(
                  hintText: 'Search Movie...',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.mic_outlined,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
      ),
    ),
  );
}
