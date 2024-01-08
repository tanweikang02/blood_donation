import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/DonationEventScreen.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medilab_prokit/utils/MLColors.dart';

class MapScreen extends StatefulWidget {
  static String tag = '/MapScreen';

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late GoogleMapController mapController;
  LatLng _center = LatLng(3.07256580057994, 101.6066459027185);
  Set<Marker> mapMarkers = {};
  FirebaseFirestore db = FirebaseFirestore.instance;
  String name =
      "Chua E Heng"; // NOTE: NEED TO DO FIREBASE AUTH, TEMPORARY SOLUTION
  var noEventInCity = true; // Used to check if there are any events in city

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    init();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> init() async {
    Position p = await _determinePosition();
    // _center = LatLng(3.0997, 101.5661);
    _center = LatLng(p.latitude, p.longitude);

    mapMarkers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: MarkerId("You"),
        position: _center,
        infoWindow: InfoWindow(
          title: "You",
        ),
      ),
    );

    // Get Current Location's City
    List<Placemark> placemarks =
        // await placemarkFromCoordinates(3.0997, 101.5661);
        await placemarkFromCoordinates(p.latitude, p.longitude);
    String? currentCity = placemarks[0].locality;

    await db.collection("donation events").get().then((event) {
      // Used to check if there are any events in city
      // var noEventInCity = true;

      // Adding Markers to Map
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");

        var e = DonationEvent.fromMap(doc.data());
        mapMarkers.add(Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(doc.id),
          position: e.latlng!,
          infoWindow: InfoWindow(
            title: e.locationName,
            snippet: "Click to learn more",
            onTap: () => DonationEventScreen(event: e).launch(context),
          ),
        ));

        // Check if document's city == current city
        if (e.city == currentCity) {
          noEventInCity = false;
        }
      }
    });

    if (noEventInCity) {
      bool hasUserVoted = await checkIfUserVoted(currentCity!, name);

      if (!hasUserVoted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("No events in your city"),
                  content: Text(
                      "There are no events in your city. Are you interested to have donation events in your city?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        upsertInterestedUser(currentCity!, name);
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("No"))
                  ],
                ));
      }
    }

    setState(() {});
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Upsert interested user to event
  Future<void> upsertInterestedUser(String city, String username) async {
    QuerySnapshot querySnapshot =
        await db.collection("city_votes").where("city", isEqualTo: city).get();

    if (querySnapshot.docs.length > 0) {
      // Increment vote count
      int currentInterestedCount = querySnapshot.docs[0]["vote"] ?? 0;

      // Update city_votes
      await db
          .collection("city_votes")
          .doc(querySnapshot.docs[0].id)
          .update({"vote": currentInterestedCount + 1});
    } else {
      // Create
      await db.collection("city_votes").add({'city': city, 'vote': 1});
    }

    // Add user to user_city_votes
    await db.collection("user_city_votes").add({
      'name': username,
      'voted_city': city,
    });
  }

  // Check if user has voted
  Future<bool> checkIfUserVoted(String city, String username) async {
    QuerySnapshot querySnapshot = await db
        .collection("user_city_votes")
        .where("name", isEqualTo: username)
        .where("voted_city", isEqualTo: city)
        .get();

    return querySnapshot.docs.length > 0;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                mlBackToPreviousWidget(context, white),
                8.width,
                Text('Donation Spots',
                        style: boldTextStyle(size: 22, color: white))
                    .expand(),
                // Icon(Icons.info_outline, color: white, size: 22),
                8.width,
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: mapMarkers,
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
