import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../controller/mapController.dart';

class MapScreen extends StatefulWidget {
  final String eventLocation;

  MapScreen({super.key, required this.eventLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  void _loadRoute() async {
    mapController.currentLocation.value =
        await mapController.getCurrentLocation();
    mapController.destinationLocation.value =
        (await mapController.getLatLngFromCity(widget.eventLocation))!;

    if (mapController.destinationLocation.value != null) {
      await mapController
          .updatePolyline(mapController.destinationLocation.value);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        title: Text(
          "Google Maps",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapController.currentLocation.value ??
                    LatLng(19.7515, 75.7139),
                zoom: 7,
              ),
              markers: mapController.markers.toSet(),
              polylines: mapController.polylines.toSet(),
              onMapCreated: (GoogleMapController controller) {
                mapController.mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: mapController.searchController,
                decoration: InputDecoration(
                  hintText: "Search location...",
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: mapController.searchLocation,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onSubmitted: (value) => mapController.searchLocation(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: "directions",
            onPressed: () => mapController.updatePolyline(
              mapController.destinationLocation.value,
            ),
            child: Icon(Icons.directions),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: "navigation",
            onPressed: mapController.startNavigation,
            child: Icon(Icons.navigation),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: "currentLocation",
            onPressed: mapController.getCurrentLocation,
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
