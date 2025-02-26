import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for navigation

class MapController extends GetxController {
  var currentLocation = LatLng(19.7515, 75.7139).obs; // Default: Maharashtra
  var destinationLocation = LatLng(18.5204, 73.8567).obs; // Pune
  var polylineCoordinates = <LatLng>[].obs;
  var polylines = <Polyline>{}.obs;
  var currentAddress = "Fetching location...".obs; // ✅ Store readable address

  GoogleMapController? mapController;
  var markers = <Marker>{}.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    log("ENTER");
    getCurrentLocation();
  }
Future<void> getCurrentLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error", "Location permissions are permanently denied.");
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLocation.value = LatLng(position.latitude, position.longitude);

    // ✅ Convert Coordinates to Address
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks.first;
      currentAddress.value = "${place.locality}, ${place.administrativeArea}";
    } else {
      currentAddress.value = "Unknown location";
    }

    update(); // Notify UI
  } catch (e) {
    Get.snackbar("Error", "Could not fetch location");
    currentAddress.value = "Location unavailable";
  }
}

  Future<void> updatePolyline(LatLng destination) async {
    polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(
        currentLocation.value.latitude,
        currentLocation.value.longitude,
      ),
      destination: PointLatLng(destination.latitude, destination.longitude),
      mode: TravelMode.driving,
    );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyBZZN7xmQTurBDm_REzavv3vbKlU8umYGM",
      request: request,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polylines.clear();
    polylines.add(
      Polyline(
        polylineId: PolylineId("route"),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ),
    );

    destinationLocation.value = destination;
    update();
  }

  Future<void> searchLocation() async {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      Get.snackbar("Error", "Please enter a location to search");
      return;
    }

    try {
      log("Searching for: $query");

      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(query);

      if (locations.isNotEmpty) {
        geocoding.Location location = locations.first;
        LatLng searchedLocation = LatLng(location.latitude, location.longitude);

        markers.add(
          Marker(
            markerId: MarkerId("search"),
            position: searchedLocation,
            infoWindow: InfoWindow(title: query),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );

        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(searchedLocation, 14),
          );
        }

        updatePolyline(searchedLocation);
      } else {
        Get.snackbar("Error", "No results found for '$query'");
      }
    } catch (e) {
      log("Search error: $e");
      Get.snackbar("Error", "Invalid location or network issue");
    }
  }

  void restrictMapToMaharashtra(CameraPosition position) {
    double latitude = position.target.latitude;
    double longitude = position.target.longitude;

    if (latitude < 15.0 ||
        latitude > 22.0 ||
        longitude < 72.0 ||
        longitude > 81.0) {
      Get.snackbar("Restricted", "You can only navigate in Maharashtra.");
      mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(19.7515, 75.7139)),
      );
    }
  }

  Future<void> startNavigation() async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=${currentLocation.value.latitude},${currentLocation.value.longitude}&destination=${destinationLocation.value.latitude},${destinationLocation.value.longitude}&travelmode=driving";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(
        Uri.parse(googleMapsUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.snackbar("Error", "Could not open Google Maps");
    }
  }
}
