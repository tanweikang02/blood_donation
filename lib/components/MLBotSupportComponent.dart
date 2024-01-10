import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLChatListComponent.dart';
import 'package:medilab_prokit/screens/MLBotScreen.dart';

class MLBotSupportComponent extends StatefulWidget {
  static String tag = '/MLBotSupportComponent';

  @override
  MLBotSupportComponentState createState() => MLBotSupportComponentState();
}

class MLBotSupportComponentState extends State<MLBotSupportComponent> {
  List<String> botsData = <String>[
    'Nearest Blood Donation Location',
    'Prerequisites before Donating Blood'
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat History', style: boldTextStyle()),
            16.height,
            MLChatListComponent(botsData, Colors.yellow, MLBotScreen()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //

          MLBotScreen().launch(context);
          setState(() {
            botsData = <String>[
              'New Chat',
              'Nearest Blood Donation Location',
              'Prerequisites before Donating Blood',
            ];
          });
        },
        icon: Icon(Icons.add),
        isExtended: true,
        label: Text('New Chat'),
      ).paddingOnly(top: 16, bottom: 16),
    );
  }
}
