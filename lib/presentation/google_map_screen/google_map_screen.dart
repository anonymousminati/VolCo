import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/google_map_screen/controller/google_map_controller.dart';

class GoogleMapScreen extends GetView<GoogleMapScreenController> {
  GoogleMapScreen({required this.destinationCordinates, Key? key})
      : super(key: key) {
    controller.updatedestination(destinationCordinates!);
  }
  final LatLng? destinationCordinates;

  @override
  Widget build(BuildContext context) {
    // Initialize the map in the controller (if not already done)
    // controller.initializeMap(); // You may call this in onInit of the controller instead

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Event Navigation"),
          actions: [
            CustomImageView(
              imagePath: ImageConstant.imgArrowLeft,
              height: 28.h,
              width: 30.h,
              onTap: () => Get.back(),
            ),
          ],
        ),
        body: Obx(() {
          return GoogleMap(
            style: controller.googleMapDarkStyle.value,
            onMapCreated: (GoogleMapController mapController) {
              controller.mapController = mapController;
            },
            initialCameraPosition: CameraPosition(
              target: controller.currentPosition.value ??
                  GoogleMapScreenController.initialCameraPosition.target,
              zoom: 18,
            ),
            markers: controller.markers.value,
            polylines: Set<Polyline>.of(controller.polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
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
