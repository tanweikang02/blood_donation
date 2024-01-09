import 'package:flutter/material.dart';
import 'package:medilab_prokit/extensions/datetime.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLTopHospitalData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';
import 'package:medilab_prokit/utils/MLImage.dart';

class DonationEventComponent extends StatelessWidget {

  final DonationEvent event;

  const DonationEventComponent({super.key, required this.event});

  Widget mOption(var value) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(child: Icon(Icons.location_searching, size: 12).paddingRight(8)),
          TextSpan(text: value, style: secondaryTextStyle(size: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DonationEvent e = event;

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
              e.imageUrl.validate(),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(8.0),
            16.height,

            Text((e.name).validate(), style: boldTextStyle()),
            16.height,
            Divider(thickness: 0.5),
            16.height,

            mOption('Hosted by'),
            8.height,
            Text(
              e.host.validate(),
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,

            mOption('Location'),
            8.height,
            Text(
              e.locationName.validate(),
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,

            mOption('Starts at'),
            8.height,
            Text(
              "${e.startDateTime?.toReadableFormat().validate()}",
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,

             mOption('Ends at'),
            8.height,
            Text(
              "${e.endDateTime?.toReadableFormat().validate()}",
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,

            mOption('Description'),
            4.height,
            Text(
              e.description.validate(),
              style: primaryTextStyle(color: mlPrimaryColor),
            ).paddingLeft(18.0),
            16.height,
          ],
        ),
      ).paddingAll(16.0),
    );
  }
}
