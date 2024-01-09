import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLImage.dart';

class MLChatListComponent extends StatefulWidget {
  List<String> data;
  Color color;
  Widget screen;

  MLChatListComponent(this.data, this.color, this.screen);

  @override
  MLChatListComponentState createState() => MLChatListComponentState();
}

class MLChatListComponentState extends State<MLChatListComponent> {
  int notificationCounter = 3;

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
    return Column(
      children: widget.data.map(
        (e) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: e.validate(), style: boldTextStyle()),
                            ],
                          ),
                        ),
                        Text('01/01/24', style: boldTextStyle()),
                      ],
                    ),
                  ],
                ).expand(),
              ],
            ).onTap(
              () {
                hideKeyboard(context);
                widget.screen.launch(context);
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
