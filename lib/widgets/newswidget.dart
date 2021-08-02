import 'package:flutter/material.dart';

Widget newsWidget(Color mainText, Color subText, Color foreground, iposNewsList,
    int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
                // borderRadius: BorderRadius.circular(8.0),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                    iposNewsList[index]['urlToImage'],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              "${iposNewsList[index]['title']}",
              style: TextStyle(fontSize: 16, color: mainText),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Text(
              "Source: ${iposNewsList[index]['source']}",
              style: TextStyle(fontSize: 12, color: subText),
            ),
          ),
        ],
      ),
    ),
  );
}
