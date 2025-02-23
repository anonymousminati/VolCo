import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/project_constants.dart'; // Contains your GOOGLE_MAP_API_KEY

class GoogleMapScreenController extends GetxController {
  final Location _location = Location();
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(18.5172655, 73.8514514), // Default location
    zoom: 15,
  );
  // Observable current position (updated live)
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  RxString googleMapDarkStyle = "".obs;
  // Destination – you may change this as needed.
  late final LatLng destination;

  // Markers observable
  RxSet<Marker> markers = <Marker>{}.obs;

  // Polylines observable
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;

  // Google Map Controller
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    _initializeLocation();
  }

  void updatedestination(LatLng destinationCordinates) {
    destination = destinationCordinates;
    _updateMarkers();
    _updatePolyline();
  }

  Future<void> _initializeLocation() async {
    googleMapDarkStyle.value =
        await rootBundle.loadString(ImageConstant.mapDarkStyle);
    // Request location service and permission
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Listen to location updates
    _location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        currentPosition.value =
            LatLng(locationData.latitude!, locationData.longitude!);
        _updateMarkers();
        // Optionally, if you want to update the polyline in real time, call _updatePolyline()
        _updatePolyline();
      }
    });
  }

  // Update markers based on current location and destination
  void _updateMarkers() {
    final Set<Marker> updatedMarkers = {};

    if (currentPosition.value != null) {
      updatedMarkers.add(
        Marker(
          markerId: const MarkerId('currentUser'),
          position: currentPosition.value!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    updatedMarkers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: destination,
        infoWindow: const InfoWindow(title: 'Event Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    markers.value = updatedMarkers;
  }

  // Fetch polyline points between current position and destination and update the polyline
  Future<void> _updatePolyline() async {
    if (currentPosition.value == null) return;
    final polylinePoints = PolylinePoints();
    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAP_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(
            currentPosition.value!.latitude, currentPosition.value!.longitude),
        destination: PointLatLng(destination!.latitude, destination!.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      final List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      final PolylineId id = const PolylineId('route');
      final Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 5,
      );

      polylines[id] = polyline;
    }
  }

  // Call this method when a button is pressed to print location info
  void zoomToCurrentLocation() {
    if (currentPosition.value != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition.value!,
            zoom: 18, // Adjust zoom level as needed
          ),
        ),
      );
    } else {
      print("Current location not available");
    }
  }
}
