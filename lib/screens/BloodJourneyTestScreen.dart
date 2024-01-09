import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BloodJourneyTestScreen extends StatefulWidget {
  @override
  State<BloodJourneyTestScreen> createState() => _BloodJourneyTestScreenState();
}

class _BloodJourneyTestScreenState extends State<BloodJourneyTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infection Test', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                    child: Text('Covid 19', style: TextStyle(fontSize: 15))),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                    child: Text('Trypanosoma cruzi',
                        style: TextStyle(fontSize: 15))),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                    child: Text('Hepatitis B virus',
                        style: TextStyle(fontSize: 15))),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                    child: Text('Hepatitis C virus',
                        style: TextStyle(fontSize: 15))),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                  child: Text('Human Immunodeficiency viruses, Types 1 and 2',
                      style: TextStyle(fontSize: 15)),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                  child: Text('Human T-Lymphotropic virus',
                      style: TextStyle(fontSize: 15)),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                  child: Text('Syphilis ', style: TextStyle(fontSize: 15)),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
                Expanded(
                  child: Text('Zika virus', style: TextStyle(fontSize: 15)),
                ),
              ]),
            ],
          ),
        ));
  }
}
