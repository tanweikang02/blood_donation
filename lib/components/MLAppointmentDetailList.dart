import 'package:flutter/material.dart';
import 'package:medilab_prokit/providers/appointment_provider.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:provider/provider.dart';

class MLAppointmentDetailList extends StatefulWidget {
  MLAppointmentDetailList();
  @override
  MLAppointmentDetailListState createState() => MLAppointmentDetailListState();
}

class MLAppointmentDetailListState extends State<MLAppointmentDetailList> {
  // List<MLTopHospitalData> topHospitalList = mlHospitalListDataList();

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

  Widget mOption(var value) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
              child: Icon(Icons.location_searching, size: 12).paddingRight(8)),
          TextSpan(text: value, style: secondaryTextStyle(size: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 80),
        padding: EdgeInsets.all(12.0),
        decoration: boxDecorationWithRoundedCorners(
          border: Border.all(color: mlColorLightGrey),
          borderRadius: radius(12),
          backgroundColor: context.cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonCachedNetworkImage(
              blood_donation_event.validate(),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(8.0),
            16.height,
            Text(context.watch<AppointmentProvider>().name,
                style: boldTextStyle()),
            16.height,
            Divider(thickness: 0.5),
            16.height,
            mOption('Date & Time'),
            8.height,
            Text(
              context.watch<AppointmentProvider>().dateTime,
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,
            mOption('Address'),
            8.height,
            Text(
              context.watch<AppointmentProvider>().address,
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,
            mOption('Payment Method'),
            4.height,
            Text('Cash', style: primaryTextStyle(color: mlPrimaryColor))
                .paddingLeft(18.0),
          ],
        ),
      ).paddingAll(16.0),
    );
  }
}
