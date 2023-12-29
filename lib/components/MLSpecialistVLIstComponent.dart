import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/model/MLSpecialistData.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLDataProvider.dart';

class MLSpecialistVListComponent extends StatefulWidget {
  static String tag = '/MLSpecialistVListComponent';

  @override
  MLSpecialistVListComponentState createState() => MLSpecialistVListComponentState();
}

class MLSpecialistVListComponentState extends State<MLSpecialistVListComponent> {
  List<MLSpecialistData> data = mlSpecialistDataDataList();

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
      children: data.map((e) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(12.0),
            border: Border.all(color: mlColorLightGrey),
            backgroundColor: context.cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: appStore.isDarkModeOn ? cardDarkColor : mlColorGreyShade,
                  borderRadius: radius(12.0),
                ),
                child: Image.asset(e.image.validate(), fit: BoxFit.fill, width: 48, height: 48),
              ),
              8.height,
              Text(e.title.validate(), style: boldTextStyle()),
              4.height,
              Text(e.subtitle.validate(), style: secondaryTextStyle(size: 16)),
            ],
          ),
        );
      }).toList(),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
    );
  }
}
