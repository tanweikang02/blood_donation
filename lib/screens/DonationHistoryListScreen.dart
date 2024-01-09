import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/screens/BloodJourneyScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';

class DonationHistoryListScreen extends StatefulWidget {
  const DonationHistoryListScreen({Key? key}) : super(key: key);

  @override
  _DonationHistoryListScreenState createState() =>
      _DonationHistoryListScreenState();
}

class _DonationHistoryListScreenState extends State<DonationHistoryListScreen> {
  List<DonationRecord> records = [];

  @override
  void initState() {
    super.initState();
    fetchHistoryRecords();
  }

  Future<void> fetchHistoryRecords() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("donation records").get().then((record) {
      for (var doc in record.docs) {
        print("${doc.id} => ${doc.data()}");

        var r = DonationRecord.fromMap(doc.data());
        records.add(r);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                mlBackToPreviousWidget(context, white),
                8.width,
                Text('Donation Records',
                        style: boldTextStyle(size: 22, color: white))
                    .expand(),
                // Icon(Icons.info_outline, color: white, size: 22),
                8.width,
              ],
            ).paddingAll(16.0),
            8.height,
            Row(
              children: [
                Container(
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radiusOnly(topRight: 32),
                          backgroundColor:
                              appStore.isDarkModeOn ? black : white,
                        ),
                        child: Column(
                          children: records.map(
                            (e) {
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
                                              decoration:
                                                  boxDecorationWithRoundedCorners(
                                                backgroundColor: mlPrimaryColor,
                                                borderRadius: radius(12),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      (e.donationDateTime?.day
                                                              .toString())
                                                          .validate(),
                                                      style: boldTextStyle(
                                                          size: 32,
                                                          color: white)),
                                                  Text(
                                                      "${e.donationDateTime?.month.toMonthName(isHalfName: true)} ${e.donationDateTime?.year}"
                                                          .validate(),
                                                      style: secondaryTextStyle(
                                                          color: white)),
                                                ],
                                              ),
                                            ),
                                            8.width,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        (e.location).validate(),
                                                        softWrap: true,
                                                        style: boldTextStyle(
                                                            size: 18)),
                                                    8.height,
                                                    Text(
                                                        (e.donorName)
                                                            .validate(),
                                                        style:
                                                            secondaryTextStyle()),
                                                    8.height,
                                                    Text(
                                                        (e.donationDateTime
                                                                ?.toReadableFormat())
                                                            .validate(),
                                                        style:
                                                            secondaryTextStyle()),
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
                                                style: boldTextStyle(
                                                    color: mlPrimaryColor)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                              backgroundColor: mlPrimaryColor,
                                              borderRadius: radius(20)),
                                      child: Text(
                                        (e.isVoluntary == true
                                            ? "Voluntary"
                                            : "Paid"),
                                        style: secondaryTextStyle(color: white),
                                      ).paddingOnly(right: 10.0, left: 10.0),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ).paddingAll(16))
                    .onTap(() {
                  BloodJourneyScreen().launch(context);
                }).expand(),
              ],
            ).expand()
          ],
        ),
      ),
    );
  }
}
