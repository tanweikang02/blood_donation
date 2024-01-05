// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/model/BloodRequest.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/model/MLDoctorData.dart';
import 'package:medilab_prokit/screens/CreateBloodRequestScreen.dart';
import 'package:medilab_prokit/screens/MLDoctorDetailScreen.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:medilab_prokit/components/DonationEventComponent.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailList.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/MLAddVoucherScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class ListBloodRequestScreen extends StatefulWidget {
  @override
  State<ListBloodRequestScreen> createState() => _ListBloodRequestScreenState();
}

class _ListBloodRequestScreenState extends State<ListBloodRequestScreen> {
  List<BloodRequest> requests = [];

  @override
  void initState() {
    super.initState();
    fetchBloodRequests();
  }

  Future<void> fetchBloodRequests() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("blood requests").get().then((req) {
      for (var doc in req.docs) {
        print("${doc.id} => ${doc.data()}");

        var r = BloodRequest.fromMap(doc.data());
        requests.add(r);
      }
    });

    setState(() {
      
    });
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
                  Text('Blood Requests', style: boldTextStyle(size: 18))
                      .paddingLeft(16),
                ],
              ).paddingAll(16.0),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Requests', style: boldTextStyle(size: 24)),
                            8.height,
                            Text(
                                'People are in urgent need of blood. Help them out!',
                                style: secondaryTextStyle()),
                            16.height,
                          ],
                        ).expand(),
                        GestureDetector(
                          onTap: () => CreateBloodRequestScreen().launch(context),
                          child: mlRoundedIconContainer(Icons.create, mlColorBlue)),
                        16.width,
                        mlRoundedIconContainer(
                            Icons.calendar_view_day_outlined, mlColorBlue),
                      ],
                    ),
                    8.height,
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 75),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        BloodRequest req = requests[index];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(12.0),
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: radius(12),
                            border: Border.all(color: mlColorLightGrey100),
                            backgroundColor: context.cardColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 4.0),
                                    height: 65,
                                    width: 65,
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: mlColorCyan,
                                      borderRadius: radius(12),
                                    ),
                                    child: Image.asset(
                                        ml_ic_doctor_image.validate(),
                                        fit: BoxFit.fill),
                                  ),
                                  8.width,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          req.location.validate(),
                                          maxLines: 3,
                                          style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text(req.text.validate(),
                                          style: secondaryTextStyle()),
                                    ],
                                  ).expand(),
                                ],
                              ),
                              16.height,
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                      color: Colors.grey, size: 16),
                                  6.width,
                                  Text('Date: ',
                                      style: secondaryTextStyle()),
                                  Text(req.date!.toReadableFormat().validate(),
                                      style: boldTextStyle(
                                          size: 14,
                                          color: Colors.grey.shade700)),
                                  8.width,
                                ],
                              ),
                              Divider(height: 32),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                        backgroundColor: Colors.blue.shade500,
                                        borderRadius: radius(20)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.bloodtype, color: white, size: 18,),
                                        8.width,
                                        Text(req.bloodTypeNeeded!
                                                  .join(",")
                                                  .validate(),
                                                style: secondaryTextStyle(
                                                    color: white))
                                      ],
                                    ).paddingSymmetric(vertical: 5, horizontal: 16)
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Details',
                                            style: primaryTextStyle(
                                                color: mlPrimaryColor)),
                                        WidgetSpan(
                                          child: Icon(Icons.arrow_forward,
                                                  color: mlPrimaryColor,
                                                  size: 16)
                                              .paddingLeft(4),
                                        ),
                                      ],
                                    ),
                                  ).onTap(
                                    () {
                                      MLDoctorDetailScreen().launch(context);
                                    },
                                  )
                                ],
                              ),
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
