// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';

// class GetLocationScreen extends StatefulWidget {
//   const GetLocationScreen({super.key});

//   @override
//   _GetLocationScreenState createState() => _GetLocationScreenState();
// }

// class _GetLocationScreenState extends State<GetLocationScreen> {
//   LatLng? _currentPosition;
//   GoogleMapController? _mapController;
//   final Location _location = Location();

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndGetLocation();
//   }

//   Future<void> _checkPermissionsAndGetLocation() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       _getUserLocation();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content:
//                 Text('Location permission is required to use this feature.')),
//       );
//     }
//   }

//   Future<void> _getUserLocation() async {
//     try {
//       final locationData = await _location.getLocation();
//       setState(() {
//         _currentPosition =
//             LatLng(locationData.latitude!, locationData.longitude!);
//       });
//     } catch (e) {
//       print("Error getting location: $e");
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//     if (_currentPosition != null) {
//       _mapController!.animateCamera(
//         CameraUpdate.newLatLngZoom(_currentPosition!, 15),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Get Location'),
//       ),
//       body: _currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition!,
//                 zoom: 15,
//               ),
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               onTap: (position) {
//                 setState(() {
//                   _currentPosition = position;
//                 });
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_currentPosition != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Selected Location: $_currentPosition')),
//             );
//           }
//         },
//         child: const Icon(Icons.check),
//       ),
//     );
//   }
// }
