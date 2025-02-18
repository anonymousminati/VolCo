import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/google_map_screen/controller/google_map_controller.dart';
import 'package:volco/widgets/custom_elevated_button.dart';

class GoogleMapScreen extends GetView<GoogleMapScreenController> {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the map in the controller (if not already done)
    // controller.initializeMap(); // You may call this in onInit of the controller instead

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Event Navigation"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // Print current location info when the button is pressed
                controller.zoomToCurrentLocation();
              },
            )
          ],
        ),
        body: Obx(() {
          return GoogleMap(

            onMapCreated: (GoogleMapController mapController) {
              controller.mapController = mapController;
            },
            initialCameraPosition: CameraPosition(
              target: controller.currentPosition.value ?? GoogleMapScreenController.initialCameraPosition.target,
              zoom: 15,
            ),
            markers: controller.markers.value,
            polylines: Set<Polyline>.of(controller.polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.zoomToCurrentLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
