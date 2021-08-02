import 'package:flutter/material.dart';
import 'package:ipos/getData.dart';

SetNews setnews = new SetNews();
Widget newsToUpdateWidget(Color mainText, Color subText, Color foreground,
    newsList, int index, BuildContext context) {
  print("news list ..................> $newsList");
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            newsList[index]['urlToImage'],
            width: 450,
            height: 250,
          ),
        ),
        SizedBox(height: 10),
        Text("Source:${newsList[index]['source']['name']}"),
        SizedBox(height: 10),
        Text("title: ${newsList[index]['title']}"),
        SizedBox(height: 10),
        Text("description: ${newsList[index]['description']}"),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              setnews.addUser(
                  index,
                  newsList[index]['source']['name'],
                  newsList[index]['title'],
                  newsList[index]['description'],
                  newsList[index]['urlToImage'],
                  newsList[index]['url'],
                  newsList[index]['publishedAt']);
            },
            child: Text("$index Upload"))
      ],
    )),
  );
}
