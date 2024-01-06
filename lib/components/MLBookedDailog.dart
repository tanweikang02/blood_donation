import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLImage.dart';

class MLBookedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(''),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ml_ic_appointment_booked.toString(),
                width: 250, height: 200, fit: BoxFit.cover),
            Text(
              'Appointment Pending Approval',
              style: boldTextStyle(size: 24),
              textAlign: TextAlign.center,
            ),
            4.height,
            Text(
              'If the appointment is approved by any hospital, you will receive a confirmation message via phone.',
              style: secondaryTextStyle(size: 12),
              textAlign: TextAlign.center,
            ),
            16.height,
            AppButton(
              height: 50,
              width: context.width(),
              color: mlPrimaryColor,
              child: Text("Close", style: primaryTextStyle(color: whiteColor)),
              onTap: () {
                finish(context);
                finish(context);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[],
    );
  }
}
