import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/core/app_export.dart';

class LocationPickerWidget extends StatefulWidget {
  final Function(String placeName, LatLng coordinates) onLocationSelected;

  const LocationPickerWidget({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  GoogleMapController? mapController;
  LatLng currentPosition = const LatLng(18.5172655, 73.8514514); // Default Pune
  String selectedPlaceName = "Search for a location";
  final TextEditingController searchPlaceController = TextEditingController();
  String sessionToken = '1234567890';
  Uuid uuid = const Uuid();
  List<dynamic> listforPlaces = [];
  bool isSearching = false;
  String googleMapDarkStyle = "";

  @override
  void initState() {
    super.initState();
    getMapStyle();
    searchPlaceController.addListener(onModify);
  }

  Future<void> getMapStyle() async {
    googleMapDarkStyle =
    await rootBundle.loadString(ImageConstant.mapDarkStyle);
    setState(() {}); // Refresh to apply map style
  }

  void onModify() {
    // Ensure sessionToken is set (it will never be null because we provided a default)
    makeSuggestions(searchPlaceController.text);
  }

  Future<void> makeSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        listforPlaces = [];
      });
      return;
    }

    String request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$GOOGLE_MAP_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        listforPlaces = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load places data');
    }
  }

  Future<void> updateMapLocation(String placeId, String placeName) async {
    String request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAP_API_KEY';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      double lat = result['result']['geometry']['location']['lat'];
      double lng = result['result']['geometry']['location']['lng'];

      setState(() {
        selectedPlaceName = placeName;
        currentPosition = LatLng(lat, lng);
        listforPlaces = [];
        isSearching = false;
      });

      // Animate the camera to the new location
      mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition));
    } else {
      throw Exception('Failed to load place details');
    }
  }

  // Helper method to build markers based on current state
  Set<Marker> _buildMarkers() {
    return {
      Marker(
        markerId: const MarkerId('selectedLocation'),
        position: currentPosition,
        infoWindow: InfoWindow(title: selectedPlaceName),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen Google Map
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              // Set dark map style
              mapController?.setMapStyle(googleMapDarkStyle);
            },
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: 18,
            ),
            markers: _buildMarkers(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
          ),
        ),
        // Search Bar & Place Suggestions (stacked on top)
        Positioned(
          top: 40,
          left: 15,
          right: 15,
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: TextField(
                  controller: searchPlaceController,
                  decoration: InputDecoration(
                    hintText: "Search for a place...",
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: isSearching
                        ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          searchPlaceController.clear();
                          listforPlaces = [];
                          isSearching = false;
                        });
                      },
                    )
                        : null,
                  ),
                  onTap: () => setState(() => isSearching = true),
                ),
              ),
              // Suggestion List
              if (listforPlaces.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listforPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          listforPlaces[index]['description'],
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          updateMapLocation(
                              listforPlaces[index]['place_id'],
                              listforPlaces[index]['description']);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        // Selected Place Name Card (stacked near the bottom)
        Positioned(
          bottom: 80,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 5),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedPlaceName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Confirm Button (at the bottom)
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              widget.onLocationSelected(selectedPlaceName, currentPosition);
              Navigator.pop(context); // Close the modal/bottom sheet
            },
            child: const Text(
              "Confirm Location",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
