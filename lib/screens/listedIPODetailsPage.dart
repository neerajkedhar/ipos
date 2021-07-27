import 'package:flutter/material.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';

class ListedIPODetailsPage extends StatefulWidget {
  ListedIPODetailsPage(this.listt, {Key? key}) : super(key: key);
  var listt;

  @override
  _ListedIPODetailsPageState createState() => _ListedIPODetailsPageState();
}

class _ListedIPODetailsPageState extends State<ListedIPODetailsPage> {
  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  CategoryServices cats = new CategoryServices();
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = colors.accent;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    print(widget.listt);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text("${widget.listt['ipo-details']['ipo-name']}"),
      ),
      body: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: foreground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.network("${widget.listt['logo']}",
                            height: 50, width: 50),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.listt['ipo-details']['ipo-name']}",
                              style: TextStyle(fontSize: 18, color: mainText),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${widget.listt['ipo-details']['company-name']}",
                                style: TextStyle(fontSize: 12, color: subText)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Listing Details"),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: foreground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['listing-date']}"),
                                  SizedBox(height: 5),
                                  Text("Listed on",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("1234"),
                                  SizedBox(height: 5),
                                  Text("Listing Price",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("79 (57%)",
                                    style: TextStyle(color: Colors.green)),
                                SizedBox(height: 5),
                                Text("Listing Gains",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("BSE, NSE"),
                                SizedBox(height: 5),
                                Text("Listed at",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("IPO Details"),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: foreground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['bidding-dates']}"),
                                  SizedBox(height: 5),
                                  Text("Bidding dates",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['allotment-date']}"),
                                  SizedBox(height: 5),
                                  Text("Allotment date",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['listing-date']}"),
                                  SizedBox(height: 5),
                                  Text("listing date",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['issue-price']}"),
                                  SizedBox(height: 5),
                                  Text("Issue Price",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${widget.listt['ipo-details']['issue-size']}"),
                                  SizedBox(height: 5),
                                  Text("Issue Size",
                                      style: TextStyle(
                                          fontSize: 12, color: subText)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Text(
                                            "DRHP ",
                                            style: TextStyle(color: accent),
                                          ),
                                          SizedBox(height: 30),
                                          Icon(
                                            Icons.open_in_new,
                                            color: accent,
                                            size: 18,
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.listt['ipo-details']['face-value']}"),
                                SizedBox(height: 5),
                                Text("face value",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.listt['ipo-details']['retail-portion']}"),
                                SizedBox(height: 5),
                                Text("Retail portion",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.listt['ipo-details']['market-lot']}"),
                                SizedBox(height: 5),
                                Text("Market Lot",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.listt['ipo-details']['min-amount']}"),
                                SizedBox(height: 5),
                                Text("Min amount",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.listt['ipo-details']['listing-at']}"),
                                SizedBox(height: 5),
                                Text("Listing at",
                                    style: TextStyle(
                                        fontSize: 12, color: subText)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          "RHP ",
                                          style: TextStyle(color: accent),
                                        ),
                                        SizedBox(height: 30),
                                        Icon(
                                          Icons.open_in_new,
                                          color: accent,
                                          size: 18,
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
