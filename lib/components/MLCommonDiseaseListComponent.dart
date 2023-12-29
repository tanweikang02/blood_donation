import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLDiseaseData.dart';
import 'package:medilab_prokit/screens/MLDiseaseSymptomsScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';

class MLCommonDiseaseListComponent extends StatefulWidget {
  static String tag = '/MLCommonDiseaseListComponent';

  @override
  MLCommonDiseaseListComponentState createState() => MLCommonDiseaseListComponentState();
}

class MLCommonDiseaseListComponentState extends State<MLCommonDiseaseListComponent> {
  List<MLDiseaseData> data = mlDiseaseDataList();

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
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: data.map((e) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(12),
            border: Border.all(color: mlColorLightGrey),
            backgroundColor: context.cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonCachedNetworkImage(e.image.validate(), fit: BoxFit.cover, height: 100).cornerRadiusWithClipRRect(12.0),
              8.height,
              Text(e.title.validate(), style: boldTextStyle()),
              4.height,
              Text(e.subtitle.validate(), style: secondaryTextStyle(size: 16)),
            ],
          ),
        ).onTap(
          () {
            MLDieaseseSymptomsScreen().launch(context);
          },
        );
      }).toList(),
    );
  }
}
