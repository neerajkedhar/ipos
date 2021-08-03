import 'package:flutter/material.dart';
import 'package:ipos/screens/listedIPODetailsPage.dart';
import 'package:ipos/screens/liveIPODetailsPage.dart';
import 'package:ipos/screens/upcomingIPODetailsPage.dart';

Widget liveipowidget(
    Color mainText, subText, foreground, var listt, int index, var context) {
  bool isAvailable = listt[index]['available'];
  String aboutFromCloud =
      isAvailable ? listt[index]['about-company']['about'] : "kkk";

  final newString = aboutFromCloud.replaceAll("\\n", "\n");
  var some = isAvailable ? listt[index]['subscription-details'].length : 2;
  var rii;
  var date;
  if (some > 2) {
    if (listt[index]['subscription-details']['day3'] != null) {
      rii = listt[index]['subscription-details']['day3']['rii'];
      date = listt[index]['subscription-details']['day3']['date'];
      print("zooom....3 $rii");
    } else if (listt[index]['subscription-details']['day2'] != null) {
      rii = listt[index]['subscription-details']['day2']['rii'];
      date = listt[index]['subscription-details']['day2']['date'];
      print("zooom....2 $rii");
    } else if (listt[index]['subscription-details']['day1'] != null) {
      rii = listt[index]['subscription-details']['day1']['rii'];
      date = listt[index]['subscription-details']['day1']['date'];
      print("zooom....1 $rii");
    } else {
      rii = "-";
      date = "-";
    }
  }

  return isAvailable
      ? GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LiveIPODetailsPage(listt[index])),
            );
          },
          child: Container(
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
                      Image.network(
                        "${listt[index]?['logo']}",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${listt[index]?['ipo-details']['ipo-name']}",
                            style: TextStyle(fontSize: 18, color: mainText),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${listt[index]['ipo-details']['company-name']}",
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
                          Text(
                              "${listt[index]['ipo-details']['bidding-dates']}",
                              style: TextStyle(fontSize: 14, color: mainText)),
                          Text("Bidding dates",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              "₹${listt[index]['ipo-details']['issue-price']}"),
                          Text("issue price",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text("${listt[index]['ipo-details']['market-lot']}"),
                          Text("lot",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Expected Premium(GMP) is ₹${listt[index]['gmp']['price']}.",
                    style: TextStyle(fontSize: 12, color: subText),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "IPO is subscribed $rii in Retail Market as of $date.",
                    style: TextStyle(fontSize: 12, color: subText),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Allotment date ${listt[index]['ipo-details']['allotment-date']}.",
                      style: TextStyle(fontSize: 12, color: subText)),
                ],
              ),
            ),
          ),
        )
      : Container();
}

Widget upcomingipowidget(
    Color mainText, subText, foreground, var listt, int index, var context) {
  bool isAvailable = listt[index]['available'];
  return isAvailable
      ? GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpcomingIPODetailsPage(listt[index])),
            );
          },
          child: Container(
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
                      Image.network(
                        "${listt[index]['logo']}",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${listt[index]['ipo-details']['ipo-name']}",
                            style: TextStyle(fontSize: 18, color: mainText),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${listt[index]['ipo-details']['company-name']}",
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
                          Text(
                              "${listt[index]['ipo-details']['bidding-dates']}",
                              style: TextStyle(fontSize: 14, color: mainText)),
                          Text("Bidding dates",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              "₹${listt[index]['ipo-details']['issue-price']}"),
                          Text("issue price",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text("${listt[index]['ipo-details']['market-lot']}"),
                          Text("lot",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Expected Premium(GMP) is ₹${listt[index]['gmp']['price']}.",
                    style: TextStyle(fontSize: 12, color: subText),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        )
      : Container();
}

Widget listedipowidget(
    Color mainText, subText, foreground, var listt, int index, var context) {
  bool isAvailable = listt[index]['available'];
  return isAvailable
      ? GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListedIPODetailsPage(listt[index])),
            );
          },
          child: Container(
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
                      Image.network(
                        "${listt[index]['logo']}",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${listt[index]['ipo-details']['ipo-name']}",
                            style: TextStyle(fontSize: 18, color: mainText),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${listt[index]['ipo-details']['company-name']}",
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
                          Text(
                              "${listt[index]['ipo-details']['bidding-dates']}",
                              style: TextStyle(fontSize: 14, color: mainText)),
                          Text("Bidding dates",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              "₹${listt[index]['ipo-details']['issue-price']}"),
                          Text("issue price",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                      Column(
                        children: [
                          Text("${listt[index]['ipo-details']['market-lot']}"),
                          Text("lot",
                              style: TextStyle(fontSize: 12, color: subText))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Listed at ₹${listt[index]['gmp']['price']} with ₹ ${listt[index]['gmp']['percent']}% listing gains",
                    style: TextStyle(fontSize: 12, color: subText),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "IPO is subscribed ${listt[index]['subscription-details']['day3']['rii']} in Retail Market as of ${listt[index]['subscription-details']['day1']['date']}.",
                    style: TextStyle(fontSize: 12, color: subText),
                  ),
                ],
              ),
            ),
          ),
        )
      : Container();
}
