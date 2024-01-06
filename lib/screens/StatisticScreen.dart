import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationRecord.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:medilab_prokit/utils/LineChart.dart';
import 'package:medilab_prokit/utils/BarChart.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  void initState() {
    super.initState();
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
              Text('Statistics', style: boldTextStyle(size: 22, color: white))
                  .expand(),
              // Icon(Icons.info_outline, color: white, size: 22),
              8.width,
            ],
          ).paddingAll(16.0),
          8.height,
          Column(
            children: [
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32),
                  backgroundColor: appStore.isDarkModeOn ? black : white,
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 0,
                      automaticallyImplyLeading: false,
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            text: "Donations",
                          ),
                          Tab(
                            text: "Key Variables",
                          ),
                          Tab(
                            text: "New Donors",
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Text('Malaysia: Blood Donations',
                              textAlign: TextAlign.start,
                              style: boldTextStyle(
                                size: 15,
                                color: black,
                                weight: FontWeight.bold,
                              )),
                          SizedBox(height: 25),
                          SizedBox(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ), // Set your desired padding
                              child: LineChart(mainData()),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),
                          Text('Breakdown of Donations by Key Variables',
                              textAlign: TextAlign.start,
                              style: boldTextStyle(
                                size: 15,
                                color: black,
                                weight: FontWeight.bold,
                              )),
                          SizedBox(height: 25),
                          SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Container(
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .red.shade100, // Set the background color
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius for rounded corners
                                  // You can also add a border, shadows, etc. here
                                ),
                                child: BarChartSample1(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text('Donor Recruitment')
                    ]),
                  ),
                ),
              ).expand(),
            ],
          ).expand(),
        ],
      ),
    ));
  }
}


// class _StatisticScreenState extends State<StatisticScreen> {
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: mlPrimaryColor,
//       body: Column(
//         children: [
//           Row(
//             children: [
//               mlBackToPreviousWidget(context, white),
//               8.width,
//               Text('Statistics', style: boldTextStyle(size: 22, color: white))
//                   .expand(),
//               // Icon(Icons.info_outline, color: white, size: 22),
//               8.width,
//             ],
//           ).paddingAll(16.0),
//           8.height,
//           Column(
//             children: [
//               Container(
//                 decoration: boxDecorationWithRoundedCorners(
//                   borderRadius: radiusOnly(topRight: 32),
//                   backgroundColor: appStore.isDarkModeOn ? black : white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 25),
//                     Text('Malaysia: Blood Donations',
//                         textAlign: TextAlign.start,
//                         style: boldTextStyle(
//                           size: 15,
//                           color: black,
//                           weight: FontWeight.bold,
//                         )),
//                     SizedBox(height: 25),
//                     Flexible(
//                       flex: 1, // Adjust flex factor to control space allocation
//                       child: SizedBox(
//                         height: 200,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20.0,
//                             right: 20.0,
//                           ), // Set your desired padding
//                           child: LineChart(mainData()),
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 1, // The thickness of the line itself
//                       color: Colors.grey, // Color of the divider
//                     ),
//                     SizedBox(height: 25),
//                     Text('Breakdown of Donations by Key Variables',
//                         textAlign: TextAlign.start,
//                         style: boldTextStyle(
//                           size: 15,
//                           color: black,
//                           weight: FontWeight.bold,
//                         )),
//                     SizedBox(height: 25),
//                     Flexible(
//                       flex: 1, // Adjust flex factor to control space allocation
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         child: SizedBox(
//                           child: Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors
//                                   .red.shade100, // Set the background color
//                               borderRadius: BorderRadius.circular(
//                                   10), // Set the border radius for rounded corners
//                               // You can also add a border, shadows, etc. here
//                             ),
//                             child: BarChartSample1(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ).expand(),
//             ],
//           ).expand(),
//         ],
//       ),
//     ));
//   }
// }