import 'package:flutter/material.dart';
import 'package:ipos/data/admobAds.dart';
import 'package:ipos/data/uicolors.dart';
import 'package:ipos/getData.dart';
import 'package:ipos/widgets/liveipowidget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveIPODetailsPage extends StatefulWidget {
  LiveIPODetailsPage(this.listt, {Key? key}) : super(key: key);
  var listt;
  @override
  _LiveIPODetailsPageState createState() => _LiveIPODetailsPageState();
}

class _LiveIPODetailsPageState extends State<LiveIPODetailsPage>
    with TickerProviderStateMixin {
  late TabController _controller1;
  late TabController _controller;
  @override
  void initState() {
    super.initState();

    _controller1 = TabController(
      length: indexReturntabs(),
      vsync: this,
      initialIndex: 0,
    );
    _controller = TabController(length: 3, vsync: this);
  }

  int indexReturntabs() {
    if (widget.listt['subscription-details']['sub'] == "3") {
      return 3;
    } else if (widget.listt['subscription-details']['sub'] == "2") {
      return 2;
    } else if (widget.listt['subscription-details']['sub'] == "1") {
      return 1;
    }
    return 3;
  }

  String returnText() {
    if (widget.listt['subscription-details']['sub'] == "3") {
      return "Retail Investors(You): ${widget.listt['subscription-details']['day3']['rii']}";
    } else if (widget.listt['subscription-details']['sub'] == "3") {
      return "Retail Investors(You): ${widget.listt['subscription-details']['day2']['rii']}";
    } else {
      return "Retail Investors(You): ${widget.listt['subscription-details']['day1']['rii']}";
    }
  }

  Widget returntabs() {
    if (widget.listt['subscription-details']['sub'] == "3") {
      return TabBar(
          controller: _controller1,
          indicatorColor: accent,
          labelColor: accent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: "${widget.listt['subscription-details']['day3']['date']}",
            ),
            Tab(
              text: "${widget.listt['subscription-details']['day2']['date']}",
            ),
            Tab(
              text: "${widget.listt['subscription-details']['day1']['date']}",
            )
          ]);
    } else if (widget.listt['subscription-details']['sub'] == "2") {
      return TabBar(
          controller: _controller1,
          indicatorColor: accent,
          labelColor: accent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: "${widget.listt['subscription-details']['day2']['date']}",
            ),
            Tab(
              text: "${widget.listt['subscription-details']['day1']['date']}",
            )
          ]);
    } else {
      return TabBar(
          controller: _controller1,
          indicatorColor: accent,
          labelColor: accent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: "${widget.listt['subscription-details']['day1']['date']}",
            )
          ]);
    }
  }

  @override
  void dispose() {
    show();
    super.dispose();
  }

  String _url = 'https://evault.kfintech.com/ipostatus/';
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  late Color background;
  late Color foreground;
  late Color accent;
  late Color mainText;
  late Color subText;
  AppColors colors = AppColors();
  CategoryServices cats = new CategoryServices();
  @override
  Widget build(BuildContext context) {
    String aboutCompany = widget.listt['about-company']['about'];
    final newString = aboutCompany.replaceAll("\\n", "\n");
    String prosCompany = widget.listt['prosandcons']['pros'];
    final pros = prosCompany.replaceAll("\\n", "\n");
    String consCompany = widget.listt['prosandcons']['cons'];
    final cons = consCompany.replaceAll("\\n", "\n");
    String objectiveCompany = widget.listt['issue-objective'];
    final objective = objectiveCompany.replaceAll("\\n", "\n");
    print(MediaQuery.of(context).size.width);
    background = Theme.of(context).brightness == Brightness.dark
        ? colors.darkBG
        : colors.liteBG;
    foreground = Theme.of(context).brightness == Brightness.dark
        ? colors.darkFG
        : colors.liteFG;
    accent = Theme.of(context).brightness == Brightness.dark
        ? colors.accent
        : colors.accentL;
    mainText = Theme.of(context).brightness == Brightness.dark
        ? colors.darkmaintext
        : colors.litemaintext;
    subText = Theme.of(context).brightness == Brightness.dark
        ? colors.darksubtext
        : colors.litesubtext;
    print(widget.listt);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: background,
          title: Text("${widget.listt['ipo-details']['ipo-name']}",
              style: TextStyle(color: mainText)),
          actions: [
            IconButton(
                onPressed: () {
                  Share.share(
                      '${widget.listt['ipo-details']['ipo-name']} \n GMP:  ₹${widget.listt['gmp']['price']} \n Bidding dates: ${widget.listt['ipo-details']['bidding-dates']} \n Issue Price: ₹${widget.listt['ipo-details']['issue-price']} \n Issue Size ₹${widget.listt['ipo-details']['issue-size']} \n ${returnText()}');
                },
                icon: Icon(
                  Icons.share_rounded,
                  color: mainText,
                )),
            SizedBox(width: 20),
          ],
          leading: IconButton(
              onPressed: () {
                show();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainText,
              )),
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
                                  style:
                                      TextStyle(fontSize: 12, color: subText)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("GMP"),
                  ),
                  gmp(),
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
                      padding: const EdgeInsets.all(26.0),
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
                                        "${widget.listt['ipo-details']['refunds-date']}"),
                                    SizedBox(height: 5),
                                    Text("Initiation of Refunds",
                                        style: TextStyle(
                                            fontSize: 12, color: subText)),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${widget.listt['ipo-details']['credit-of-shares']}"),
                                    SizedBox(height: 5),
                                    Text("Credit of Shares",
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
                                        "₹${widget.listt['ipo-details']['issue-size']}"),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "₹${widget.listt['ipo-details']['issue-price']}"),
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
                                      "₹${widget.listt['ipo-details']['face-value']}"),
                                  SizedBox(height: 5),
                                  Text("Face value",
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
                                      "₹${widget.listt['ipo-details']['min-amount']}"),
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Subsciption Details"),
                  ),
                  Container(
                      child: Column(children: [
                    returntabs(),
                    returnTabContainers(),
                  ])),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Company Details"),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: foreground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Founded: ',
                                style: TextStyle(color: subText, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${widget.listt['about-company']['founded']}",
                                    style: TextStyle(
                                        color: mainText, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: 'Manager: ',
                                style: TextStyle(color: subText, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${widget.listt['about-company']['manager']}",
                                    style: TextStyle(
                                        color: mainText, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: 'About Company: ',
                                style: TextStyle(color: subText, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "$newString",
                                    style: TextStyle(
                                        color: mainText, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Company Financials (₹ in millions) "),
                  ),
                  returnFinancialsTab(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Company Valuation"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: foreground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Earnings Per Ratio (EPS): "),
                            Text("₹${widget.listt['valuation']['eps']}")
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("NAV: "),
                            Text("₹${widget.listt['valuation']['nav']}")
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("P/E Ratio: "),
                            Text("${widget.listt['valuation']['pe-ratio']}")
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("RoNW: "),
                            Text("${widget.listt['valuation']['ronw']}")
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pros & Cons"),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: foreground,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pros:"),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "$pros",
                                    style: TextStyle(
                                      color: subText,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Cons:"),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "$cons",
                                    style: TextStyle(
                                      color: subText,
                                    ),
                                  ),
                                ),
                              ]))),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Issue-Objective"),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: foreground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("$objective"),
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Promoters"),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: foreground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("${widget.listt['promoters']}"),
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Disclaimer"),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: foreground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            "Any financial information or ideas published anywhere within this application, should not be considered as an advice to buy or sell securities or invest in IPOs. All matter published here is purely for education and information purpose only. All the infomation published in this application is gathered from the online and other news publications, so the information here may not be accurate and under no circumstances you should use this information to make investment decisions. \n \n We are not SEBI registered analyst. App users must consult a qualified financial advisor prior to making actual investment or financial decisions, \n\n YOUR USE OF THE APP AND YOUR RELIANCE ON ANY INFORMATION ON THE APP IS SOLELY AT YOUR OWN RISK. \n\nyou agree with the Terms and Conditions to use this Application."),
                      )),
                  SizedBox(height: 60),
                ],
              ),
            )),
        floatingActionButton: widget.listt['isAllotmentOpen'] == true
            ? GestureDetector(
                onTap: () => _launchURL(),
                child: Container(
                  width: (MediaQuery.of(context).size.width) * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: accent,
                  ),
                  child: Center(
                    child: Text(
                      "Check Allotment",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ))
            : Container()
        //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }

  Widget gmp() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: foreground,
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expected Grey Market Premium"),
                  widget.listt['gmp']['positive'] == true
                      ? Text("+ ₹${widget.listt['gmp']['price']}",
                          style: TextStyle(color: accent))
                      : Text("- ₹${widget.listt['gmp']['price']}",
                          style: TextStyle(color: Colors.redAccent)),
                ])));
  }

  Widget returnFinancialsTab() {
    return Container(
        child: Column(children: [
      TabBar(
          controller: _controller,
          indicatorColor: accent,
          labelColor: accent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: "Total Assets",
            ),
            Tab(
              text: "Total Revenue",
            ),
            Tab(
              text: "Profit After Tax",
            )
          ]),
      SizedBox(
        height: 150,
        child: TabBarView(controller: _controller, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar1']['year']}"),
                    Text("₹${widget.listt['financials']['mar1']['assets']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar2']['year']}"),
                    Text("₹${widget.listt['financials']['mar2']['assets']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar3']['year']}"),
                    Text("₹${widget.listt['financials']['mar3']['assets']}")
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar1']['year']}"),
                    Text("₹${widget.listt['financials']['mar1']['revenue']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar2']['year']}"),
                    Text("₹${widget.listt['financials']['mar2']['revenue']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar3']['year']}"),
                    Text("₹${widget.listt['financials']['mar3']['revenue']}")
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar1']['year']}"),
                    Text("₹${widget.listt['financials']['mar1']['profit']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar2']['year']}"),
                    Text("₹${widget.listt['financials']['mar2']['profit']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "31 Mar ${widget.listt['financials']['mar3']['year']}"),
                    Text("₹${widget.listt['financials']['mar3']['profit']}")
                  ],
                ),
              ]),
            ),
          ),
        ]),
      )
    ]));
  }

  Widget returnTabContainers() {
    if (widget.listt['subscription-details']['sub'] == "3") {
      return SizedBox(
        height:
            widget.listt['subscription-details']['day1'].length > 5 ? 220 : 180,
        child: TabBarView(controller: _controller1, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day3']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day3']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day3']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day3'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day3']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day3'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day3']['total']}")
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day2'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day2']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day2'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['total']}")
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day1'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day1']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day1'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['total']}")
                  ],
                ),
              ]),
            ),
          ),
        ]),
      );
    } else if (widget.listt['subscription-details']['sub'] == "2") {
      return SizedBox(
        height:
            widget.listt['subscription-details']['day1'].length > 5 ? 220 : 180,
        child: TabBarView(controller: _controller1, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day2'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day2']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day2'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day2']['total']}")
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day1'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day1']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day1'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['total']}")
                  ],
                ),
              ]),
            ),
          ),
        ]),
      );
    } else {
      return SizedBox(
        height:
            widget.listt['subscription-details']['day1'].length > 5 ? 220 : 180,
        child: TabBarView(controller: _controller1, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foreground,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Retail Individual Investors(You) :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['rii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Non-Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['nii']}")
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualified Institutional Investors :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['qib']}")
                  ],
                ),
                SizedBox(height: 20),
                widget.listt['subscription-details']['day1'].length > 5
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Employee :"),
                          Text(
                              "${widget.listt['subscription-details']['day1']['emp']}")
                        ],
                      )
                    : Container(),
                widget.listt['subscription-details']['day1'].length > 5
                    ? SizedBox(height: 20)
                    : SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total :"),
                    Text(
                        "${widget.listt['subscription-details']['day1']['total']}")
                  ],
                ),
              ]),
            ),
          ),
        ]),
      );
    }
  }
}
