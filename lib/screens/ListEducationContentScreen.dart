import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/screens/BloodJourneyScreen.dart';
import 'package:medilab_prokit/screens/education/EducationContent_1.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';

class ListEducationContentScreen extends StatelessWidget {
  const ListEducationContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => finish(context),
                      child: mlBackToPreviousWidget(context, white)),
                  8.width,
                  Text('Youngblood Guide',
                          style: boldTextStyle(size: 22, color: white))
                      .expand(),
                  // Icon(Icons.info_outline, color: white, size: 22),
                  8.width,
                ],
              ).paddingAll(16.0),
              8.height,
              SingleChildScrollView(
                child: 
                  Container(
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: radiusOnly(topRight: 32),
                            backgroundColor:
                                appStore.isDarkModeOn ? black : white,
                          ),
                          child: Column(children: [
                            16.height,
                            //
                            // Content 1
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: boxDecorationWithRoundedCorners(
                                border: Border.all(color: mlColorLightGrey100),
                                backgroundColor: context.cardColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        edu_1.validate(),
                                        width: double.infinity,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ).cornerRadiusWithClipRRect(8.0),
                                      Positioned(
                                        top: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: white,
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius: radius(24),
                                          ),
                                          child: Icon(Icons.favorite,
                                              color: Colors.red, size: 16),
                                          // : InkWell(
                                          //     onTap: () {
                                          //       setState(() {
                                          //         liked = true;
                                          //       });
                                          //     },
                                          //     child: Icon(Icons.favorite_outline, color: Colors.grey, size: 16),
                                          //   ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: mlPrimaryColor,
                                            borderRadius: radius(12),
                                          ),
                                          child: Text(
                                            "109 views".validate(),
                                            style:
                                                secondaryTextStyle(color: white),
                                          ).paddingOnly(right: 8.0, left: 8.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  16.height,
                                  Text(("Can you donate blood?").validate(),
                                      style: boldTextStyle()),
                                  8.height,
                                  Text(("BloodBud Admin").validate(),
                                      style: secondaryTextStyle()),
                                  8.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(Icons.star,
                                                      color: Colors.yellow)
                                                  .paddingRight(4),
                                            ),
                                            TextSpan(
                                                text: "5.0",
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Learn more',
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                            WidgetSpan(
                                              child: Icon(Icons.arrow_forward,
                                                      color: mlPrimaryColor,
                                                      size: 16)
                                                  .paddingLeft(4),
                                            ),
                                          ],
                                        ),
                                      ).onTap(() {
                                        EducationContent1().launch(context);
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            32.height,
                            //
                            // Content 2
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: boxDecorationWithRoundedCorners(
                                border: Border.all(color: mlColorLightGrey100),
                                backgroundColor: context.cardColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        blood_donation_event.validate(),
                                        width: double.infinity,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ).cornerRadiusWithClipRRect(8.0),
                                      Positioned(
                                        top: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: white,
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius: radius(24),
                                          ),
                                          child: Icon(Icons.favorite,
                                              color: Colors.red, size: 16),
                                          // : InkWell(
                                          //     onTap: () {
                                          //       setState(() {
                                          //         liked = true;
                                          //       });
                                          //     },
                                          //     child: Icon(Icons.favorite_outline, color: Colors.grey, size: 16),
                                          //   ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: mlPrimaryColor,
                                            borderRadius: radius(12),
                                          ),
                                          child: Text(
                                            ("88 views").validate(),
                                            style:
                                                secondaryTextStyle(color: white),
                                          ).paddingOnly(right: 8.0, left: 8.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  16.height,
                                  Text(("Here is how to start your blood donation journey").validate(),
                                      style: boldTextStyle()),
                                  8.height,
                                  Text(("BloodBud Admin").validate(),
                                      style: secondaryTextStyle()),
                                  8.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(Icons.star,
                                                      color: Colors.yellow)
                                                  .paddingRight(4),
                                            ),
                                            TextSpan(
                                                text: "5.0",
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Learn more',
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                            WidgetSpan(
                                              child: Icon(Icons.arrow_forward,
                                                      color: mlPrimaryColor,
                                                      size: 16)
                                                  .paddingLeft(4),
                                            ),
                                          ],
                                        ),
                                      ).onTap(() {
                                        // MLHospitalDetailScreen().launch(context);
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            32.height,
                            //
                            // Content 3
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: boxDecorationWithRoundedCorners(
                                border: Border.all(color: mlColorLightGrey100),
                                backgroundColor: context.cardColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        edu_3.validate(),
                                        width: double.infinity,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ).cornerRadiusWithClipRRect(8.0),
                                      Positioned(
                                        top: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: white,
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius: radius(24),
                                          ),
                                          child: Icon(Icons.favorite,
                                              color: Colors.red, size: 16),
                                          // : InkWell(
                                          //     onTap: () {
                                          //       setState(() {
                                          //         liked = true;
                                          //       });
                                          //     },
                                          //     child: Icon(Icons.favorite_outline, color: Colors.grey, size: 16),
                                          //   ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16.0,
                                        right: 16.0,
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: mlPrimaryColor,
                                            borderRadius: radius(12),
                                          ),
                                          child: Text(
                                            ("3,699 views").validate(),
                                            style:
                                                secondaryTextStyle(color: white),
                                          ).paddingOnly(right: 8.0, left: 8.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  16.height,
                                  Text(("Rapid Recovery - Zero to Hero").validate(),
                                      style: boldTextStyle()),
                                  8.height,
                                  Text(("BloodBud Admin").validate(),
                                      style: secondaryTextStyle()),
                                  8.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(Icons.star,
                                                      color: Colors.yellow)
                                                  .paddingRight(4),
                                            ),
                                            TextSpan(
                                                text: "5.0",
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Learn more',
                                                style: primaryTextStyle(
                                                    color: Colors.grey.shade500)),
                                            WidgetSpan(
                                              child: Icon(Icons.arrow_forward,
                                                      color: mlPrimaryColor,
                                                      size: 16)
                                                  .paddingLeft(4),
                                            ),
                                          ],
                                        ),
                                      ).onTap(() {
                                        // MLHospitalDetailScreen().launch(context);
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            32.height,
          
          
                          ]).paddingAll(16))
                      .expand(),
                
              ).expand()
            ],
          ),
        ),
      ),
    );
  }
}
