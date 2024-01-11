import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateBloodRequestScreen extends StatefulWidget {
  const CreateBloodRequestScreen({Key? key}) : super(key: key);

  @override
  _CreateBloodRequestScreenState createState() =>
      _CreateBloodRequestScreenState();
}

class _CreateBloodRequestScreenState extends State<CreateBloodRequestScreen> {
  static const List<String> BLOOD_TYPES = [
    "O-",
    "O+",
    "B-",
    "B+",
    "A-",
    "A+",
    "AB-",
    "AB+"
  ];

  TextEditingController locationController = TextEditingController();
  TextEditingController descTextController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  List<String> selectedBloodTypes = [];

  FocusNode locationFocusNode = FocusNode();
  FocusNode descTextFocusNode = FocusNode();
  FocusNode recipientNameFocusNode = FocusNode();

  // TODO: add firestore/cloud function to create blood requests & send push notifications
  Future<void> raiseBloodRequest() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("blood requests").add({
      "text": descTextController.text,
      "location": locationController.text,
      "date": DateTime.now(),
      "bloodTypeNeeded": selectedBloodTypes,
      "recipientName": recipientNameController.text
    }).then((documentSnapshot) async {
      print("Added Data with ID: ${documentSnapshot.id}");

      FirebaseFunctions functions =
          FirebaseFunctions.instanceFor(region: "us-central1");
      functions.useFunctionsEmulator("localhost", 5001);
      HttpsCallable callable = functions.httpsCallable("sendNotifications");
      final result = await callable(<String, dynamic>{
        'bloodTypeNeeded': selectedBloodTypes,
        'location': locationController.text,
      });
      bool success = result.data;

      if (success) {
        showConfirmDialog(
            context, "We have alerted people about your request!");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    messageHandler();
  }

  Future<void> messageHandler() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // print("Sent notifications successfully");
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message.notification!.title, message.notification!.body);

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        // showNotification(
        //     message.notification!.title, message.notification!.body);
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  void showNotification(String? title, String? body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String? title, String? body) async {
    var android = AndroidInitializationSettings("@mipmap/ic_launcher");
    var initialSetting = new InitializationSettings(android: android);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initialSetting);
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_notification_channel_id', 'Notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: "@mipmap/ic_launcher",
      // icon: "images/blood_transfusion.png",
      playSound: true,
      // sound: RawResourceAndroidNotificationSound("notification")
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
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
                    () => finish(context),
                  ),
                  8.width,
                  Text('Request for blood', style: boldTextStyle(size: 18))
                      .paddingLeft(16),
                ],
              ).paddingAll(16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location', style: boldTextStyle()),
                  AppTextField(
                    controller: locationController,
                    focus: locationFocusNode,
                    textFieldType: TextFieldType.OTHER,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText: "Where the blood is needed?",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  Text('Description Text', style: boldTextStyle()),
                  AppTextField(
                    controller: descTextController,
                    focus: descTextFocusNode,
                    textFieldType: TextFieldType.MULTILINE,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText:
                          "Write something for people to understand the situation...",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  Text('Blood Types Needed', style: boldTextStyle()),
                  MultiSelectDialogField(
                    items:
                        BLOOD_TYPES.map((e) => MultiSelectItem(e, e)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      selectedBloodTypes = values;
                    },
                  ),
                  16.height,
                  Text('Recipient Name (Optional)', style: boldTextStyle()),
                  AppTextField(
                    controller: recipientNameController,
                    focus: recipientNameFocusNode,
                    textFieldType: TextFieldType.OTHER,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText: "Optional",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  32.height,
                  AppButton(
                    width: context.width(),
                    color: mlPrimaryColor,
                    onTap: () {
                      raiseBloodRequest();
                    },
                    child: Text('Create >',
                        style: boldTextStyle(color: white),
                        textAlign: TextAlign.center),
                  ).paddingOnly(right: 16, left: 16, bottom: 16),
                ],
              ).paddingAll(16)
            ],
          ),
        ),
      ),
    );
  }
}
