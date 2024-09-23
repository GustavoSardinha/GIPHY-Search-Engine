
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gif_manager/widgets/gif_table.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController searchController = TextEditingController();
  String? _search;
  int _offset = 0;

  void incrementOffset(){
    setState(() {
      _offset += 19;
    });
  }
  Future<Map<String, dynamic>> _getGifs() async {
    http.Response response;
    if(_search == null || _search == ""){
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=ZuBMDdqOL3rQcIz5S2kbVoSfKfnDErQa&limit=19&offset=$_offset&rating=g&bundle=messaging_non_clips"));
    }
    else{
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=ZuBMDdqOL3rQcIz5S2kbVoSfKfnDErQa&q=$_search&limit=19&offset=$_offset&rating=g&bundle=messaging_non_clips"));
    }
    return json.decode(response.body);
  }
  @override
  void initState() {
    super.initState();
    _getGifs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Padding(
          padding: const EdgeInsets.all(16),
          child: Image.network("https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 100,
      ),
      body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Padding(
                  padding:  EdgeInsets.all(16),
                  child: Text(
                   "Pesquise por GIFs",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Busque um termo",
                            hintText: "Ex. Dogs"

                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8
                      ,),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _search = searchController.text;
                            _offset = 0;
                          });

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16
                  ,),
                Expanded(
                    child: FutureBuilder(
                        future: _getGifs(),
                        builder: (context, snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                    strokeWidth: 5.0,
                                  ),
                                ),
                              );
                            default:
                              if(snapshot.hasError){
                                return Container();
                              }
                              else{
                                return gifTable(context, snapshot, incrementOffset);
                              }

                          }

                        }
                    )
                )
              ],),
          )
    );
  }
}
