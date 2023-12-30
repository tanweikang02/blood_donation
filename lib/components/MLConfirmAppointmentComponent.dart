import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailList.dart';
import 'package:medilab_prokit/screens/MLAddVoucherScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class MLConfirmAppointmentComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text('Confirm Appointment', style: boldTextStyle(size: 24)).paddingLeft(16),
              8.height,
              Text('Find the service you are', style: secondaryTextStyle()).paddingLeft(16),
              16.height,
              MLAppointmentDetailList(),
            ],
          ),
        ),
        Text(
          'Add Voucher',
          style: boldTextStyle(color: mlPrimaryColor, decoration: TextDecoration.underline),
        ).paddingOnly(bottom: 70, right: 16).onTap(
          () {
            MLAddVoucherScreen().launch(context);
          },
        ),
      ],
    );
  }
}
