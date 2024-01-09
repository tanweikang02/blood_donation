import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/model/MLProfileCardData.dart';
import 'package:medilab_prokit/model/User.dart';
import 'package:medilab_prokit/screens/LeaderboardScreen.dart';
import 'package:medilab_prokit/screens/MLBotScreen.dart';
import 'package:medilab_prokit/screens/MilestoneScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medilab_prokit/extensions/datetime.dart';

class MLProfileBottomComponent extends StatefulWidget {
  static String tag = '/MLProfileBottomComponent';

  final User? currentUser;
  MLProfileBottomComponent({required this.currentUser});

  @override
  MLProfileBottomComponentState createState() =>
      MLProfileBottomComponentState();
}

class MLProfileBottomComponentState extends State<MLProfileBottomComponent> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<String> data = <String>[
    'Milestone',
    'Dependents',
    'Health care',
    'Refer friends and family'
  ];
  List<String> categoriesData = <String>[
    'Milestones',
    'Medical Record',
    'Medical Test',
    'Health Tracking'
  ];
  List<Color> customColor = <Color>[
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyan
  ];

  List<MLProfileCardData> mlProfileData = mlProfileDataList();
  List<String> badges = badgeList();
  List<DonationRecord> records = [];
  late User currentUser;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await fetchDonationHistory();
    setState(() {
      currentUser = widget.currentUser!;
    });
  }

  Future<void> fetchDonationHistory() async {
    await db
        .collection("donation records")
        .where("donorName", isEqualTo: widget.currentUser?.name)
        .orderBy("donationDateTime", descending: true)
        .limit(2)
        .get()
        .then((req) {
      for (var doc in req.docs) {
        print("${doc.id} => ${doc.data()}");

        var r = DonationRecord.fromMap(doc.data());
        records.add(r);
      }
    });

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? blackColor : white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Badges', style: boldTextStyle(size: 18)),
            ],
          ),
          16.height,
          // Badges
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              8.width,
              for (String badge in badgeList())
                Container(
                  margin: EdgeInsets.only(bottom: 16, right: 16),
                  child: Image.asset(
                    badge,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              8.width,
            ],
          ),
          32.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Donations', style: boldTextStyle(size: 18)),
            ],
          ),
          16.height,
          Column(
            children: records.map((e) {
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: appStore.isDarkModeOn
                          ? scaffoldDarkColor
                          : Colors.grey.shade50,
                      borderRadius: radius(12),
                    ),
                    child: Column(
                      children: [
                        20.height,
                        Row(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: mlPrimaryColor,
                                borderRadius: radius(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      (e.donationDateTime?.day.toString())
                                          .validate(),
                                      style: boldTextStyle(
                                          size: 32, color: white)),
                                  Text(
                                      "${e.donationDateTime?.month.toMonthName(isHalfName: true)} ${e.donationDateTime?.year}"
                                          .validate(),
                                      style: secondaryTextStyle(color: white)),
                                ],
                              ),
                            ),
                            8.width,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((e.location).validate(),
                                        softWrap: true,
                                        style: boldTextStyle(size: 18)),
                                    8.height,
                                    Text((e.donorName).validate(),
                                        style: secondaryTextStyle()),
                                    8.height,
                                    Text(
                                        (e.donationDateTime?.toReadableFormat())
                                            .validate(),
                                        style: secondaryTextStyle()),
                                  ],
                                ).expand(),
                              ],
                            ).expand(),
                          ],
                        ).paddingOnly(right: 16.0, left: 16.0),
                        8.height,
                        Divider(thickness: 0.5),
                        8.height,
                        Row(
                          children: [
                            Text(
                                "${e.bloodVolume_Milliliter.toString()} ml"
                                    .validate(),
                                style: boldTextStyle(color: mlPrimaryColor)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    "Payment: RM ${e.paymentAmount!.toStringAsFixed(2)}",
                                    style: secondaryTextStyle(
                                        color: mlPrimaryColor)),
                              ],
                            ).expand()
                          ],
                        ).paddingOnly(right: 16.0, left: 16.0),
                        16.height,
                      ],
                    ),
                  ).paddingBottom(16.0),
                  Positioned(
                    left: 16.0,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: mlPrimaryColor,
                          borderRadius: radius(20)),
                      child: Text(
                        (e.isVoluntary == true ? "Voluntary" : "Paid"),
                        style: secondaryTextStyle(color: white),
                      ).paddingOnly(right: 10.0, left: 10.0),
                    ),
                  ),
                ],
              ).onTap(
                () {
                  MilestoneScreen().launch(context);
                },
              );
            }).toList(),
            // mainAxisSpacing: 16.0,
            // crossAxisSpacing: 16.0,
          ),

          //  leaderboard
          16.height,
          Stack(alignment: Alignment.centerLeft, children: [
            commonCachedNetworkImage(
              leaderboard_card.validate(),
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(12.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1 Blood = 3 Lives',
                    style: primaryTextStyle(size: 20, weight: FontWeight.w900)),
                Text('Your friends are donating blood to save lives!',
                    style: secondaryTextStyle(size: 16))
              ],
            ).paddingAll(16)
          ]),

          8.height,
          GestureDetector(
            onTap: () => LeaderboardScreen().launch(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("See how your friends are doing",
                    style: secondaryTextStyle(color: mlColorBlue)),
                8.width,
                Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
              ],
            ),
          ),

          32.height,
          Container(
            // margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(8.0),
            decoration: boxDecorationRoundedWithShadow(8,
                backgroundColor: context.cardColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('images/ic_theme.png',
                            height: 24, width: 24, color: Colors.blue)
                        .paddingOnly(left: 4),
                    8.width,
                    Text('DarkMode', style: primaryTextStyle()),
                  ],
                ),
                Switch(
                  value: appStore.isDarkModeOn,
                  activeColor: appColorPrimary,
                  onChanged: (s) {
                    appStore.toggleDarkMode(value: s);
                  },
                )
              ],
            ),
          ).onTap(
            () {
              appStore.toggleDarkMode();
            },
          ),

          16.height,
          Column(
            children: data.map(
              (e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: boxDecorationRoundedWithShadow(8,
                      backgroundColor: context.cardColor),
                  child: Row(
                    children: [
                      Icon(Icons.tab, size: 24, color: Colors.blue),
                      8.width,
                      Text(e.validate(), style: primaryTextStyle()).expand(),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.grey[300], size: 16),
                    ],
                  ),
                ).onTap(
                  () {
                    MilestoneScreen().launch(context);
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
