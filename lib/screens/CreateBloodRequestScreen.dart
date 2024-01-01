import 'package:flutter/material.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateBloodRequestScreen extends StatefulWidget {
  const CreateBloodRequestScreen({Key? key}) : super(key: key);

  @override
  _CreateBloodRequestScreenState createState() =>
      _CreateBloodRequestScreenState();
}

class _CreateBloodRequestScreenState extends State<CreateBloodRequestScreen> {
  static const List<String> BLOOD_TYPES = [
    "O-",
    "O+",
    "B-",
    "B+",
    "A-",
    "A+",
    "AB-",
    "AB+"
  ];

  TextEditingController bloodTypeController = TextEditingController();
  List<String> selectedBloodTypes = [];

  FocusNode bloodTypeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  Text('Request for blood', style: boldTextStyle(size: 18))
                      .paddingLeft(16),
                ],
              ).paddingAll(16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location', style: boldTextStyle()),
                  AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText: "Where the blood is needed?",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  Text('Description Text', style: boldTextStyle()),
                  AppTextField(
                    textFieldType: TextFieldType.MULTILINE,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText:
                          "Write something for people to understand the situation...",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  Text('Blood Types Needed', style: boldTextStyle()),
                  MultiSelectDialogField(
                    items:
                        BLOOD_TYPES.map((e) => MultiSelectItem(e, e)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      selectedBloodTypes = values;
                    },
                  ),
                  16.height,
                  Text('Recipient Name (Optional)', style: boldTextStyle()),
                  AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    textStyle: primaryTextStyle(),
                    decoration: InputDecoration(
                      hintText: "Optional",
                      hintStyle: secondaryTextStyle(size: 16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  32.height,
                  AppButton(
                    width: context.width(),
                    color: mlPrimaryColor,
                    onTap: () {
                      // TODO: add firestore/cloud function to create blood requests
                    },
                    child: Text('Create >',
                        style: boldTextStyle(color: white),
                        textAlign: TextAlign.center),
                  ).paddingOnly(right: 16, left: 16, bottom: 16),
                ],
              ).paddingAll(16)
            ],
          ),
        ),
      ),
    );
  }
}
