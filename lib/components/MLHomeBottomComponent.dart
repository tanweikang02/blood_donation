import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/model/BloodRequest.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/DonationEventScreen.dart';
import 'package:medilab_prokit/screens/LeaderboardScreen.dart';
import 'package:medilab_prokit/screens/ListBloodRequestScreen.dart';
import 'package:medilab_prokit/screens/MapScreen.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLString.dart';

class MLHomeBottomComponent extends StatefulWidget {
  static String tag = '/MLHomeBottomComponent';

  @override
  MLHomeBottomComponentState createState() => MLHomeBottomComponentState();
}

class MLHomeBottomComponentState extends State<MLHomeBottomComponent> {
  List<BloodRequest> bloodRequestList = [];

  List<DonationEvent> eventList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("donation events").get().then((event) {
      for (var doc in event.docs) {
        eventList.add(DonationEvent.fromMap(doc.data()));
      }
    });

    await db.collection("blood requests").get().then((request) {
      for (var doc in request.docs) {
        bloodRequestList.add(BloodRequest.fromMap(doc.data()));
      }
    });

    eventList.sort((a, b) => b.startDateTime!.compareTo(a.startDateTime!));
    bloodRequestList.sort((a, b) => b.date!.compareTo(a.date!));

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.height,
        Row(
          children: [
            Text("Blood in Urgent Need", style: boldTextStyle(size: 18))
                .expand(),
            GestureDetector(
              onTap: () => ListBloodRequestScreen().launch(context),
              child: Text(mlView_all!,
                  style: secondaryTextStyle(color: mlColorBlue)),
            ),
            4.width,
            Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingOnly(left: 16, right: 16),
        16.height,
        bloodRequestList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonCachedNetworkImage(
                    ml_prescription3.validate(),
                    height: 88,
                    width: 88,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                  Text("No blood request.", style: secondaryTextStyle()),
                ],
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: mlColorBlue,
                          borderRadius: radius(12),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.check, color: white)
                              .paddingOnly(top: 28.0, bottom: 28.0),
                        ),
                      ), // instead of background
                      Container(
                        margin: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: context.cardColor,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: radius(12),
                        ),
                        child: Row(
                          children: [
                            4.width,
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
                                      (bloodRequestList[index]
                                              .date!
                                              .day
                                              .toString())
                                          .validate(),
                                      style: boldTextStyle(
                                          size: 32, color: white)),
                                  Text(
                                      "${bloodRequestList[index].date!.month.toMonthName(isHalfName: true)} ${bloodRequestList[index].date!.year}"
                                          .validate(),
                                      style: secondaryTextStyle(color: white)),
                                ],
                              ),
                            ),
                            10.width,
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        (bloodRequestList[index].location)
                                            .validate(),
                                        style: boldTextStyle()),
                                    8.height,
                                    Text(
                                        bloodRequestList[index]
                                            .bloodTypeNeeded!
                                            .join(", ")
                                            .validate(),
                                        style: secondaryTextStyle()),
                                    12.height,
                                    Container(
                                      child: Text(
                                          bloodRequestList[index]
                                              .text
                                              .validate(),
                                          overflow: TextOverflow.ellipsis,
                                          style: boldTextStyle(
                                              size: 14, color: mlColorBlue)),
                                    ),
                                    8.height,
                                  ],
                                ).expand(),
                              ],
                            ).expand(),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
        32.height,
        Row(
          children: [
            Text("Popular Donation Events", style: boldTextStyle(size: 18))
                .expand(),
            GestureDetector(
              onTap: () => MapScreen().launch(context),
              child: Row(
                children: [
                  Text("View map",
                      style: secondaryTextStyle(color: mlColorBlue)),
                  4.width,
                  Icon(Icons.keyboard_arrow_right,
                      color: mlColorBlue, size: 16),
                ],
              ),
            )
          ],
        ).paddingAll(16.0),
        HorizontalList(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceBetween,
          itemCount: eventList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () =>
                  DonationEventScreen(event: eventList[index]).launch(context),
              child: Container(
                width: 258,
                margin: EdgeInsets.only(bottom: 8, left: 8),
                decoration: boxDecorationRoundedWithShadow(12,
                    backgroundColor: context.cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonCachedNetworkImage(
                      (eventList[index].imageUrl).validate(),
                      height: 140,
                      width: 250,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                    8.height,
                    Text((eventList[index].name).validate(),
                            style: boldTextStyle())
                        .paddingOnly(left: 8.0),
                    4.height,
                    Text((eventList[index].description).validate(),
                            overflow: TextOverflow.ellipsis,
                            style: secondaryTextStyle())
                        .paddingOnly(left: 8.0),
                    10.height,
                    Text(
                            "${eventList[index].startDateTime!.toReadableFormat()} - ${eventList[index].endDateTime!.toReadableFormat()}"
                                .validate(),
                            overflow: TextOverflow.ellipsis,
                            style: secondaryTextStyle())
                        .paddingOnly(left: 8.0),
                    10.height,
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
