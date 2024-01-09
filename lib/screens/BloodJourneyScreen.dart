import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BloodJourneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blood Journey', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: JourneyOverview(),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: JourneyOverview(),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Column(
                        children: [
                          JourneyStep(
                              stepIcon: Icons.bloodtype_rounded,
                              title: '1. Your Donation',
                              subtitle: 'Your donation is successful',
                              icon: Icons.check_circle),
                          Divider(color: Colors.grey[400]),
                          JourneyStep(
                              stepIcon: Icons.document_scanner,
                              title: '2. Processing',
                              subtitle: 'Your donation has been processed',
                              icon: Icons.check_circle),
                          Divider(color: Colors.grey[400]),
                          JourneyStep(
                              stepIcon: Icons.search,
                              title: '3. Testing',
                              subtitle: 'Your blood is free from infections',
                              icon: Icons.check_circle),
                          Divider(color: Colors.grey[400]),
                          JourneyStep(
                              stepIcon: Icons.warehouse,
                              title: '4. Storage',
                              subtitle: 'Your blood is currently in storage',
                              icon: Icons.check_circle),
                          Divider(color: Colors.grey[400]),
                          JourneyStep(
                              stepIcon: Icons.favorite,
                              title: '5. An Impact Made',
                              subtitle: 'Your donation has helped 3 people',
                              icon: Icons.check_circle),
                        ],
                      ))),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }
}

class JourneyStep extends StatelessWidget {
  const JourneyStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.stepIcon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final IconData stepIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(this.stepIcon, color: Colors.red),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(this.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            textStyle: TextStyle(fontSize: 12)),
                        child: Text('View Details'),
                        onPressed: () {})
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Icon(this.icon, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class JourneyOverview extends StatelessWidget {
  const JourneyOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('January 7, 2023 at 10:10 AM',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: 5),
          Text('Ampang Pantai Hospital',
              style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(height: 5),
          Chip(
            labelPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.red)),
            labelStyle: TextStyle(color: Colors.white),
            // color: Colors.white,
            backgroundColor: Colors.red,
            label: const Text('Voluntary'),
          )
        ]),
      ),
    );
  }
}
