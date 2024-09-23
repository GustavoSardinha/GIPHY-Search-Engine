import 'package:flutter/material.dart';
import 'package:gif_manager/pages/gif_page.dart';
import 'package:transparent_image/transparent_image.dart';

Widget gifTable(BuildContext context, AsyncSnapshot snapshot, VoidCallback incrementOffset){
  return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
      ),
      itemCount: snapshot.data["data"].length + 1,
      itemBuilder: (context, index){
        if(index < snapshot.data["data"].length) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index])));
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            )
          );
        }
        else{
          return ElevatedButton(
              onPressed: incrementOffset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  )
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Carregar mais",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 18
                    ),
                    ),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 60,
                  ),
                ],
              ),
          );
        }
      }
  );
}