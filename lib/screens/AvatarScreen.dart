import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:medilab_prokit/model/User.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class AvatarScreen extends StatefulWidget {
  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final int avatarChangeCost = 5; // Change cost depending on what you prefer
  User? currentUser;
  bool canPurchase = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> fetchUsers() async {
    String name = "Casey Tan"; // Sufficient Credits
    // String name = "Chua E Heng"; // Insufficient Credits

    await db
        .collection("users")
        .where("name", isEqualTo: name)
        .get()
        .then((req) {
      for (var doc in req.docs) {
        print("${doc.id} => ${doc.data()}");

        currentUser = User.fromMap(doc.data());
      }
    });

    setState(() {
      if (currentUser?.points != null) {
        canPurchase = currentUser!.points! >= avatarChangeCost ? true : false;
      }
    });
  }

  Future<void> purchase() async {
    var avatar = await FluttermojiFunctions().encodeMySVGtoString();

    if (currentUser?.points != null) {
      QuerySnapshot querySnapshot = await db
          .collection("users")
          .where("name", isEqualTo: currentUser?.name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var newPoints = currentUser!.points! - avatarChangeCost;

        await db
            .collection("users")
            .doc(querySnapshot.docs[0].id)
            .update({"points": newPoints, "avatar": avatar});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Avatar changed successfully!"),
          duration: Duration(seconds: 2),
        ),
      );

      finish(context);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[90],
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
                Text('Customize Avatar', style: boldTextStyle(size: 18))
                    .paddingLeft(16),
              ],
            ).paddingAll(16.0),
            Column(
              children: <Widget>[
                8.height,
                FluttermojiCircleAvatar(
                  backgroundColor: Colors.grey[200],
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Balance: ${currentUser != null ? currentUser?.points : 0}',
                        style: secondaryTextStyle(size: 16)),
                    8.width,
                  ],
                ).paddingAll(16.0),
                FluttermojiCustomizer(
                  autosave: false,
                ).paddingAll(16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Avatar Change Cost: ${avatarChangeCost}',
                            style: secondaryTextStyle(size: 16)),
                        Visibility(
                          child: Text('Insufficient Balance',
                              style: secondaryTextStyle(
                                  size: 16, color: Colors.red)),
                          visible: !canPurchase,
                        )
                      ],
                    ),
                    Visibility(
                      child: FluttermojiSaveWidget(
                        onTap: () async {
                          await purchase();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: mlPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Purchase',
                            style: boldTextStyle(color: white),
                          ),
                        ),
                      ),
                      visible: canPurchase,
                    )
                  ],
                ).paddingAll(16.0),
              ],
            ).paddingAll(16.0),
          ],
        )),
      ),
    );
  }
}
