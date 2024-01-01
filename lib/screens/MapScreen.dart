import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medilab_prokit/main.dart';
import 'package:medilab_prokit/model/DonationEvent.dart';
import 'package:medilab_prokit/screens/DonationEventScreen.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLString.dart';

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
    _center = LatLng(p.latitude, p.longitude);

    mapMarkers = {
        Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: MarkerId("You"),
        position: _center,
        infoWindow: InfoWindow(
          title: "You",
        ),
      ),
      Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("Sunway Medical Centre"),
        position: LatLng(3.0725, 101.6066),
        infoWindow: InfoWindow(
          title: "Sunway Medical Centre",
          snippet: "Click to learn more",
          onTap: () => DonationEventScreen(event: DonationEvent(name: "Sunway de Blood Donation", description: "Sun the blood", host: "Sunway Group", locationName: "Sunway Medical Centre", startDateTime: DateTime.now(), endDateTime: DateTime.now()),).launch(context),
        ),
      ),
    };

    // TODO: retrieve event data from firestore
    // mapMarkers = from firestore
                  // Marker(
                  //   markerId: MarkerId("Donation Event"),
                  //   position: LatLng(3.0725, 101.6066),
                  //   infoWindow: InfoWindow(
                  //     title: "Sunway Medical Centre",
                  //     snippet: "Click to learn more",
                  //     onTap: () => DonationEventScreen(event: event,).launch(context),
                  //   ),
                  // ),

    setState(() { });
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
