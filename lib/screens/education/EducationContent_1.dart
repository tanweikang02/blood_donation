import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';

class EducationContent1 extends StatelessWidget {
  const EducationContent1({Key? key}) : super(key: key);

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
                  Text('Guide Post',
                          style: boldTextStyle(size: 22, color: white))
                      .expand(),
                  // Icon(Icons.info_outline, color: white, size: 22),
                  8.width,
                ],
              ).paddingAll(16.0),
              8.height,
              SingleChildScrollView(
                child: Container(
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radiusOnly(topRight: 32),
                          backgroundColor:
                              appStore.isDarkModeOn ? black : white,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.height,
                              Text(
                                "Can You Donate Blood?",
                                style: boldTextStyle(size: 24),
                              ),
                              32.height,
                              Image.asset(
                                edu_1.validate(),
                                width: double.infinity,
                                height: 188.0,
                                fit: BoxFit.cover,
                              ).cornerRadiusWithClipRRect(8.0),
                              32.height,
                              Text(
                                "Before donating blood, individuals must meet certain eligibility criteria. This criteria typically includes factors like age, weight, overall health, and specific medical conditions. It's crucial to ensure that you meet these requirements to donate safely.",
                                style: primaryTextStyle(),
                              ),
                              32.height,
                              Text("You can donate blood if:-", style: primaryTextStyle(),).paddingBottom(8),
                              Text("1. Well and healthy", style: primaryTextStyle(),).paddingBottom(8),
                              Text("2. Age:", style: primaryTextStyle(),).paddingBottom(8),
                              Text("1. First time donor: 18-60 years old", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("2. Regular donor: 18-65 years old", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("3. Prospective donor aged 17 years old must provide written consent from his or her parents / guardian", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("3. Weight : 45kg and above", style: primaryTextStyle(),).paddingBottom(8),
                              Text("4. Had minimum of 5 hours sleep", style: primaryTextStyle(),).paddingBottom(8),
                              Text("5. Had a meal before blood donation", style: primaryTextStyle(),).paddingBottom(8),
                              Text("6. No medical illness", style: primaryTextStyle(),).paddingBottom(8),
                              Text("7. Not involved in any high risk activities such as :-", style: primaryTextStyle(),).paddingBottom(8),
                              Text("1. Same gender sex (homosexual)", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("2. Bisexual", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("3. Had sex with commercial sex worker", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("4. Change in sexual partner", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("5. Took intravenous drug", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("6. A sexual partner of any of the above", style: primaryTextStyle(),).paddingOnly(bottom: 8, left: 24),
                              Text("8. Last whole blood donation was 3 months ago", style: primaryTextStyle(),).paddingBottom(8),
                              Text("9. For female donors : not pregnant, last menstrual period was more than 3 days ago, and not breastfeeding", style: primaryTextStyle(),).paddingBottom(8),


                              32.height,
                              Text("Source: Pusat Perubatan University Malaya", style: secondaryTextStyle(),).paddingBottom(8),
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
