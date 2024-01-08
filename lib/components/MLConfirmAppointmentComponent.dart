import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/providers/appointment_provider.dart';
import 'package:medilab_prokit/screens/MLBookAppointmentScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLAppointmentDetailList.dart';
import 'package:provider/provider.dart';

class MLConfirmAppointmentComponent extends StatefulWidget {
  final callChildMethodController controller;
  MLConfirmAppointmentComponent({required this.controller});
  @override
  _MLConfirmAppointmentComponentState createState() =>
      _MLConfirmAppointmentComponentState(controller);
}

class _MLConfirmAppointmentComponentState
    extends State<MLConfirmAppointmentComponent> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  _MLConfirmAppointmentComponentState(callChildMethodController _controller) {
    _controller.method = addToFirestore;
  }

  dynamic addToFirestore() {
    insertData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.bottomRight,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text('Confirm Appointment', style: boldTextStyle(size: 24))
                  .paddingLeft(16),
              8.height,
              Text('Double Check Your Information', style: secondaryTextStyle())
                  .paddingLeft(16),
              16.height,
              MLAppointmentDetailList(),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> insertData() async {
    //Insert data into database
    await db.collection("appointments").add({
      "name": context.read<AppointmentProvider>().name,
      "address": context.read<AppointmentProvider>().address,
      "datetime": context.read<AppointmentProvider>().dateTime,
      "status": "Pending",
    });
  }
}
