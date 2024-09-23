import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class GifPage extends StatelessWidget {
  final Map<String, dynamic> _gifData;
  const GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Altera a cor para branca
        ),
        actions: [
          IconButton(
              onPressed: (){
                Share.share(_gifData['images']["fixed_height"]["url"]);
              },
              icon: const Icon(Icons.share),
          )
        ],
        title:  Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                  child: Image.network("https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif")),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text("Titulo: ${_gifData['title']}",
              style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              ),
              ),
            ),
            const SizedBox(height: 16),
            Image.network(_gifData['images']["fixed_height"]["url"]),
          ],
        ),
      ),
    );
  }
}
