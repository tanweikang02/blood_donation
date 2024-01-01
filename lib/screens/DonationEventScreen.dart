// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:medilab_prokit/components/DonationEventComponent.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailList.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/MLAddVoucherScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class DonationEventScreen extends StatelessWidget {
  final DonationEvent event;

  const DonationEventScreen({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            SingleChildScrollView(
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
                      Text('Event Detail', style: boldTextStyle(size: 18))
                          .paddingLeft(16),
                    ],
                  ).paddingAll(16.0),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            DonationEventComponent(
                              event: event,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
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
                  Text("Interested", style: boldTextStyle(color: white)),
                  8.width,
                  Icon(Icons.arrow_forward_ios, color: whiteColor, size: 12),
                ],
              ),
              onTap: () {},
            ).paddingOnly(right: 16, left: 16, bottom: 16)
          ],
        ),
      ),
    );
  }
}
