// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/model/BloodRequest.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/model/MLDoctorData.dart';
import 'package:medilab_prokit/model/User.dart';
import 'package:medilab_prokit/screens/CreateBloodRequestScreen.dart';
import 'package:medilab_prokit/screens/MLDoctorDetailScreen.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:badges/badges.dart' as badges;

import 'package:medilab_prokit/components/DonationEventComponent.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailList.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/MLAddVoucherScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  Future<void> fetchUsers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("users").get().then((req) {
      for (var doc in req.docs) {
        print("${doc.id} => ${doc.data()}");

        var u = User.fromMap(doc.data());
        users.add(u);
      }
    });

    users.sort((a,b) => b.points!.compareTo(a.points!));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    color: appStore.isDarkModeOn ? white : blackColor,
                    size: 22,
                  ).onTap(
                    () {
                      finish(context);
                    },
                  ),
                  8.width,
                  Text('Leaderboard', style: boldTextStyle(size: 18))
                      .paddingLeft(16),
                ],
              ).paddingAll(16.0),
              SingleChildScrollView(
                child: Column(
                  children: [
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
                              style: primaryTextStyle(
                                  size: 20, weight: FontWeight.w900)),
                          Text('Your friends are donating blood to save lives!',
                              style: secondaryTextStyle(size: 16))
                        ],
                      ).paddingAll(16)
                    ]).paddingAll(5),
                    8.height,

                    // List
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 75),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        User user = users[index];

                        return Container(
                          margin: EdgeInsets.only(top: 8.0),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: appStore.isDarkModeOn
                                ? scaffoldDarkColor
                                : Colors.grey.shade50,
                            borderRadius: radius(12),
                          ),
                          child: Column(
                            children: [
                              12.height,
                              Row(
                                children: [
                                  badges.Badge(
                                    position: badges.BadgePosition.topStart(top: -12),
                                    badgeContent: Text("${index+1}"),
                                    badgeStyle: badges.BadgeStyle(
                                      badgeColor: Colors.amber
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 52,
                                          height: 52,
                                          child: commonCachedNetworkImage(
                                            user.profileImageUrl.validate(),
                                            fit: BoxFit.cover,
                                          ).cornerRadiusWithClipRRect(88),
                                        )
                                      ],
                                    ),
                                  ),
                                  16.width,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text((user.name).validate(),
                                          style: boldTextStyle(size: 16),
                                          overflow: TextOverflow.ellipsis,
                                          ),
                                      Row(
                                        children: [
                                          Icon(
                                        Icons.stars_rounded,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                      8.width,
                                      Text("${user.points}".validate(),
                                          style: primaryTextStyle(size: 16)),
                                        ],
                                      )
                                    ],
                                  ).expand(),
                                ],
                              ).paddingOnly(right: 16.0, left: 16.0),
                              12.height
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ).paddingAll(16.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
