import 'package:flutter/material.dart';
import 'package:medilab_prokit/components/MLBookedDailog.dart';
import 'package:medilab_prokit/providers/appointment_provider.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLBookAppointmentData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class callChildMethodController {
  late Function() method;
}

class MLBookAppointmentScreen extends StatefulWidget {
  static String tag = '/MLBookAppointmentScreen';
  final int? index;

  const MLBookAppointmentScreen({Key? key, this.index}) : super(key: key);

  @override
  MLBookAppointmentScreenState createState() => MLBookAppointmentScreenState();
}

class MLBookAppointmentScreenState extends State<MLBookAppointmentScreen> {
  int currentWidget = 0;
  late List<MLBookAppointmentData> data;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final callChildMethodController controller = callChildMethodController();

  String name =
      "Chai Waii Yuan"; // NOTE: NEED TO DO FIREBASE AUTH, TEMPORARY SOLUTION
  int minimumRequirement = 0; // Set the minimum requirement for home visit

  MLBookAppointmentScreenState() {
    data = mlBookAppointmentDataList(controller);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // Check if user has donated more than x number of times
    QuerySnapshot querySnapshot = await db
        .collection('donation records')
        .where("donorName", isEqualTo: name)
        .get();

    if (querySnapshot.docs.length < minimumRequirement) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: Text("Not enough donations"),
                content: Text(
                    "You have not donated enough times to book a home visit. The minimum requirement is ${minimumRequirement}"),
                actions: [
                  TextButton(
                    // Bring them back to previous page
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  )
                ],
              ));
    }

    currentWidget = widget.index!;
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(mlPrimaryColor);
  }

  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    String titleNumber = data[currentWidget].id.validate();
    String titleText = data[currentWidget].title.validate();
    double progress = data[currentWidget].progress.validate();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppointmentProvider(),
        )
      ],
      child: WillPopScope(
        key: navigatorKey,
        onWillPop: () async {
          if (currentWidget != 0) {
            if (navigatorKey.currentState!.canPop()) {
              currentWidget--;
              setState(() {});
              navigatorKey.currentState!.pop();
              return false;
            }
            return true;
          }
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(topRight: 32),
                    backgroundColor: appStore.isDarkModeOn ? black : white,
                  ),
                  child: Column(
                    children: <Widget>[
                      8.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: appStore.isDarkModeOn ? white : blackColor,
                            size: 22,
                          ).onTap(
                            () {
                              currentWidget == 0
                                  ? Navigator.of(context).pop()
                                  : setState(
                                      () {
                                        currentWidget--;
                                        widget.index == currentWidget;
                                      },
                                    );
                            },
                          ).expand(flex: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Step $titleNumber of 3: ',
                                textAlign: TextAlign.center,
                                style: boldTextStyle(color: mlPrimaryColor),
                              ),
                              Text(titleText,
                                  textAlign: TextAlign.center,
                                  style: boldTextStyle(color: Colors.grey)),
                            ],
                          ).expand(flex: 8),
                          Icon(Icons.home_outlined, color: blackColor, size: 24)
                              .expand(flex: 1),
                        ],
                      ).paddingAll(16.0),
                      8.height,
                      LinearProgressIndicator(
                        minHeight: 2.0,
                        backgroundColor: mlColorLightGrey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(mlPrimaryColor),
                        value: progress,
                      ),
                      8.height,
                      data[currentWidget].widget.validate().expand(),
                    ],
                  ),
                ),
                AppButton(
                  height: 50,
                  width: context.width(),
                  color: mlPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue", style: boldTextStyle(color: white)),
                      8.width,
                      Icon(Icons.arrow_forward_ios,
                          color: whiteColor, size: 12),
                    ],
                  ),
                  onTap: () {
                    setState(
                      () {
                        currentWidget++;
                      },
                    );

                    if (currentWidget > 2) {
                      setState(
                        () {
                          currentWidget--;
                        },
                      );
                      currentWidget = 0;
                      _showDialog(context);
                    }

                    controller.method();
                  },
                ).paddingOnly(right: 16, left: 16, bottom: 16)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MLBookedDialog();
      },
    );
  }
}
