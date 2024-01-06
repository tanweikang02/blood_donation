import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLInboxData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:medilab_prokit/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MLBotScreen extends StatefulWidget {
  static String tag = '/MLBotScreen';

  @override
  MLBotScreenState createState() => MLBotScreenState();
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Color.fromRGBO(240, 70, 83, 1),
          size: 100,
        ),
      ),
    ));
  }
}

class LoadingChatBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(
      color: Colors.black,
      size: 50,
    );
  }
}

class MLBotScreenState extends State<MLBotScreen> {
  TextEditingController messageController = TextEditingController();
  List<MLInboxData> data = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
    fetchChatData();
  }

  void fetchChatData() async {
    setState(() => _isLoading = true);

    var fetchedMessages = await getChat();

    setState(() {
      data = fetchedMessages;
      _isLoading = false;
    });
  }

  Future<void> init() async {
    //
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return _isLoading
        ? LoadingScreen()
        : SafeArea(
            child: Scaffold(
              backgroundColor: mlPrimaryColor,
              body: Stack(
                children: [
                  Positioned(
                    top: 8.0,
                    child: Row(
                      children: [
                        8.width,
                        mlBackToPreviousWidget(context, white),
                        8.width,
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.yellow,
                              radius: 28.0,
                              child: Image.asset(ml_ic_doctor_image!,
                                      fit: BoxFit.cover)
                                  .cornerRadiusWithClipRRect(30.0),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 6,
                              child: Icon(Icons.brightness_1_rounded,
                                  color: Colors.greenAccent, size: 14),
                            )
                          ],
                        ),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tony Bot (General Care)',
                                style:
                                    boldTextStyle(color: whiteColor, size: 18)),
                            4.height,
                            Text('Online',
                                style: secondaryTextStyle(
                                    size: 16, color: white.withOpacity(0.5))),
                          ],
                        )
                      ],
                    ).paddingAll(16.0),
                  ),
                  Container(
                    width: context.width(),
                    height: context.height(),
                    margin: EdgeInsets.only(top: 90),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radiusOnly(topRight: 32),
                      backgroundColor:
                          appStore.isDarkModeOn ? blackColor : white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          8.height,
                          Text('9:41 AM', style: secondaryTextStyle(size: 16)),
                          8.height,
                          data.length != 0
                              ? ListView.builder(
                                  padding: EdgeInsets.all(16.0),
                                  scrollDirection: Axis.vertical,
                                  reverse: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    if (data[index].role == "user") {
                                      return Column(
                                        children: [
                                          8.height,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration:
                                                    boxDecorationWithRoundedCorners(
                                                  backgroundColor:
                                                      Colors.blue.shade500,
                                                  borderRadius: radius(12.0),
                                                ),
                                                padding: EdgeInsets.all(12.0),
                                                child: Text(
                                                  (data[index].parts)
                                                      .validate(),
                                                  style: primaryTextStyle(
                                                      color: white),
                                                ),
                                              ),
                                              8.width,
                                              CircleAvatar(
                                                backgroundColor: mlColorCyan,
                                                child: Image.asset(
                                                        ml_ic_profile_picture!,
                                                        fit: BoxFit.fill)
                                                    .cornerRadiusWithClipRRect(
                                                        30.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (data[index].role == "model") {
                                      return Column(
                                        children: [
                                          8.height,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                child: Image.asset(
                                                  ml_ic_doctor_image!,
                                                  fit: BoxFit.fill,
                                                ).cornerRadiusWithClipRRect(
                                                    30.0),
                                              ),
                                              8.width,
                                              Container(
                                                decoration:
                                                    boxDecorationWithRoundedCorners(
                                                  borderRadius: radius(12.0),
                                                  backgroundColor:
                                                      appStore.isDarkModeOn
                                                          ? scaffoldDarkColor
                                                          : mlColorLightGrey100,
                                                ),
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  (data[index].parts)
                                                      .validate(),
                                                  style: primaryTextStyle(
                                                      color:
                                                          appStore.isDarkModeOn
                                                              ? white
                                                              : blackColor),
                                                ),
                                              )
                                                  .paddingOnly(right: 42.0)
                                                  .expand(),
                                            ],
                                          ),
                                        ],
                                      ).paddingOnly(right: 32.0);
                                    } else {
                                      return Column(
                                        children: [
                                          8.height,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                child: Image.asset(
                                                  ml_ic_doctor_image!,
                                                  fit: BoxFit.fill,
                                                ).cornerRadiusWithClipRRect(
                                                    30.0),
                                              ),
                                              8.width,
                                              Container(
                                                decoration:
                                                    boxDecorationWithRoundedCorners(
                                                  borderRadius: radius(12.0),
                                                  backgroundColor:
                                                      appStore.isDarkModeOn
                                                          ? scaffoldDarkColor
                                                          : mlColorLightGrey100,
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 16.0, right: 16.0),
                                                child: LoadingChatBubble(),
                                              ).paddingOnly(right: 42.0)
                                              // .expand(),
                                            ],
                                          ),
                                        ],
                                      ).paddingOnly(right: 32.0);
                                    }
                                  },
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('Beginning of chat history',
                                      style: secondaryTextStyle(size: 16)),
                                ),
                        ],
                      ),
                    ),
                  ).paddingTop(8.0),
                ],
              ),
              bottomNavigationBar: Container(
                padding: MediaQuery.of(context).viewInsets,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor,
                  borderRadius: radius(0.0),
                  border: Border.all(color: mlColorLightGrey100),
                ),
                child: Row(
                  children: [
                    8.width,
                    Icon(CupertinoIcons.smiley,
                        size: 22, color: Colors.grey.shade600),
                    4.width,
                    Icon(Icons.image_outlined,
                        size: 22, color: Colors.grey.shade600),
                    4.width,
                    Icon(Icons.mic_none, size: 22, color: Colors.grey.shade600),
                    8.width,
                    AppTextField(
                      controller: messageController,
                      textFieldType: TextFieldType.OTHER,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a reply...',
                        hintStyle: secondaryTextStyle(size: 16),
                      ),
                    ).expand(),
                    Icon(Icons.send_outlined, size: 24, color: Colors.blue)
                        .paddingAll(4.0)
                        .onTap(
                      () {
                        if (messageController.text != "") {
                          sendMessage();
                          addMessage();
                          addLoadingMessage();
                          messageController.clear();
                        }
                      },
                    ),
                    8.width,
                  ],
                ),
              ),
            ),
          );
  }

  void addMessage() {
    if (messageController.text != "") {
      FirebaseFirestore db = FirebaseFirestore.instance;
      final msg = <String, dynamic>{
        "type": 0,
        "parts": messageController.text,
        "role": "user",
        "created_at": Timestamp.now()
      };

      db.collection("chat_history").add(msg).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));

      setState(
        () {
          data.add(MLInboxData(
              type: 0, parts: messageController.text, role: "user"));
        },
      );
    } else
      return;
  }

  void addLoadingMessage() {
    if (messageController.text != "") {
      setState(
        () {
          data.add(MLInboxData(type: 2, parts: "", role: "loading"));
        },
      );
    } else
      return;
  }

  Future<void> sendMessage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseFunctions functions =
        FirebaseFunctions.instanceFor(region: "us-central1");
    // Ideal time to initialize
    functions.useFunctionsEmulator("localhost", 5001);
    HttpsCallable callable = functions.httpsCallable('sendBotMessage');
    List<Map> jsonList = data.map((item) => item.toJson()).toList();
    var jsonData = jsonEncode(jsonList);

    try {
      final results = await callable
          .call({"data": jsonData, "text": messageController.text});
      String message = results.data;
      final msg = <String, dynamic>{
        "type": 1,
        "parts": message,
        "role": "model",
        "created_at": Timestamp.now()
      };

      db.collection("chat_history").add(msg).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));

      setState(
        () {
          data.removeLast();
          data.add(MLInboxData(type: 1, parts: message, role: "model"));
        },
      );
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
    }
  }

  // Emulator
  Future<List<MLInboxData>> getChat() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<MLInboxData> chat_data = [];

    await db
        .collection("chat_history")
        .orderBy("created_at")
        .get()
        .then((event) {
      for (var doc in event.docs) {
        chat_data.add(MLInboxData.fromJson(doc.data()));
      }
    });

    return chat_data;

    // FirebaseFunctions functions =
    //     FirebaseFunctions.instanceFor(region: "us-central1");

    // // Ideal time to initialize
    // functions.useFunctionsEmulator("localhost", 5001);
    // HttpsCallable callable = functions.httpsCallable('sendChatHistory');
    // final results = await callable.call({});
    // List chat = results.data;
    // print(chat);
    // return chat.map<MLInboxData>((item) => MLInboxData.fromJson(item)).toList();
  }
}



  // Future<List> getChat(){
  //   final result = await FirebaseFunctions.instance.httpsCallable("sendChatHistory").call({});
  //   List _response = result.data as List;
  //   return _response;
  // }

  // Example
  // Future<void> getChat() async {
  //   HttpsCallable callable =
  //       FirebaseFunctions.instance.httpsCallable('sendChatHistory');
  //   final results = await callable();
  //   List chat = results.data;
  //   print(chat);
  // }
