import 'package:flutter/material.dart';

Widget liveipowidget(Color mainText, subText, foreground, var listt) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: foreground,
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company IPO",
                    style: TextStyle(fontSize: 18, color: mainText),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Company Title Limited",
                      style: TextStyle(fontSize: 12, color: subText)),
                ],
              )
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("16 Jul - 20 Jul 2021",
                      style: TextStyle(fontSize: 14, color: mainText)),
                  Text("Bidding dates",
                      style: TextStyle(fontSize: 12, color: subText))
                ],
              ),
              Column(
                children: [
                  Text("1073 - 1017"),
                  Text("issue price",
                      style: TextStyle(fontSize: 12, color: subText))
                ],
              ),
              Column(
                children: [
                  Text("13"),
                  Text("lot", style: TextStyle(fontSize: 12, color: subText))
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          Text(
            "Expected Premium(GMP) is 749 (49%)",
            style: TextStyle(fontSize: 12, color: subText),
          ),
          SizedBox(height: 5),
          Text("Going to be listed on 24 Jul 2020",
              style: TextStyle(fontSize: 12, color: subText))
        ],
      ),
    ),
  );
}
