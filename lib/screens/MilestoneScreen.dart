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
import 'package:medilab_prokit/components/ProgressBarComponent.dart';

class MilestoneScreen extends StatefulWidget {
  @override
  State<MilestoneScreen> createState() => _MilestoneScreenState();
}

class _MilestoneScreenState extends State<MilestoneScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Current",
                ),
                Tab(text: "Completed"),
              ],
            ),
            title: const Text('Milestone'),
          ),
          body: TabBarView(children: [
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    MilestoneContainer(
                      title: 'Donated Blood 5 Times',
                      progressText: '3 / 5',
                      progress: 0.6,
                      imagePath: 'images/ml_prescription1.png',
                      containerColor: Colors.red.shade300,
                      progressColor: Colors.red,
                    ),
                    MilestoneContainer(
                      title: 'Donated 4.5L of Blood',
                      progressText: '1350 / 4500',
                      progress: 0.33,
                      imagePath: 'images/ml_prescription2.png',
                      containerColor: Colors.blue.shade300,
                      progressColor: Colors.blue,
                    ),
                    MilestoneContainer(
                      title: 'Make 3 impacts with your blood',
                      progressText: '1 / 3',
                      progress: 0.33,
                      imagePath: 'images/ml_prescription3.png',
                      containerColor: Colors.amber.shade300,
                      progressColor: Colors.amber,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                )),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    MilestoneContainer(
                      title: 'Donated Blood for the 1st time',
                      progressText: '1 / 1',
                      progress: 100,
                      imagePath: 'images/ml_prescription1.png',
                      containerColor: Colors.grey.shade500,
                      progressColor: Colors.grey.shade600,
                    ),
                    MilestoneContainer(
                      title: 'Donated 450ml of Blood',
                      progressText: '450 / 450',
                      progress: 100,
                      imagePath: 'images/ml_prescription2.png',
                      containerColor: Colors.grey.shade500,
                      progressColor: Colors.grey.shade600,
                    ),
                    MilestoneContainer(
                      title: 'Make an impact with your blood',
                      progressText: '1 / 1',
                      progress: 100,
                      imagePath: 'images/ml_prescription3.png',
                      containerColor: Colors.grey.shade500,
                      progressColor: Colors.grey.shade600,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ))
          ])),
    );
  }
}

class MilestoneContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final double progress;
  final String progressText;
  final Color containerColor;
  final Color progressColor;

  const MilestoneContainer(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.progress,
      required this.progressText,
      required this.containerColor,
      required this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      width: double.infinity,
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(12), backgroundColor: containerColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              this.imagePath,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // width: 200,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.title,
                    softWrap: true,
                    style: boldTextStyle(color: Colors.white, size: 16)),
                SizedBox(height: 8),
                Container(
                  width: 200,
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the radius for desired roundness
                    child: LinearProgressIndicator(
                      value: this.progress, // 50% progress
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(this.progressText,
                    style: boldTextStyle(color: Colors.white, size: 12))
              ],
            ),
          ),
          8.width,
        ],
      ).paddingAll(16),
    );
  }
}
