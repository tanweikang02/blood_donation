import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLProfileBottomComponent.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/screens/AvatarScreen.dart';
import 'package:medilab_prokit/model/User.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';

  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? currentUser;

  Future<void> fetchUsers() async {
    String name = "Casey Tan";

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

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () => AvatarScreen().launch(context),
                          child: CircleAvatar(
                              child: FluttermojiCircleAvatar(
                                backgroundColor: Colors.transparent,
                              ),
                              radius: 40,
                              backgroundColor: mlColorCyan)),
                      8.height,
                      Text(
                          '${currentUser != null ? currentUser?.name : 'John Doe'}',
                          style: boldTextStyle(color: white, size: 24)),
                      4.height,
                      Text(
                          '${currentUser != null ? currentUser?.email : 'johnsmith@gmail.com'}',
                          style: secondaryTextStyle(color: white, size: 16)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 50,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.9,
                              center: Text("90.0%"),
                              barRadius: Radius.circular(10.0),
                              progressColor: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    if (currentUser != null) {
                      return MLProfileBottomComponent(currentUser: currentUser);
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
