// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:latlong/latlong.dart';
//
// class MapApp extends StatefulWidget {
//   @override
//   _MapAppState createState() => _MapAppState();
// }
//
// class _MapAppState extends State<MapApp> {
//   double long = 30.3753;
//   double lat = 69.3451;
//   // double long = 49.5;
//   // double lat = -0.09;
//   LatLng point = LatLng(30.3753, 69.3451);
//  // LatLng point = LatLng(49.5, -0.09);
//   List<Address> location = [];
//   List<Marker> markers = [];
// // Function to handle search
//   void searchLocation(String query) async {
//     final addresses = await Geocoder.local.findAddressesFromQuery(query);
//     if (addresses.isNotEmpty) {
//       final address = addresses.first;
//       setState(() {
//         point = LatLng(address.coordinates.latitude, address.coordinates.longitude);
//         location = [address];
//         markers.clear(); // Clear existing markers
//         markers.add(
//           Marker(
//             width: 80.0,
//             height: 80.0,
//             point: point,
//             builder: (ctx) => Container(
//               child: Icon(
//                 Icons.location_on,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         );
//       });
//     }
//   }
// //   void searchLocation(String query) async {
// //     final addresses = await Geocoder.local.findAddressesFromQuery(query);
// //     if (addresses.isNotEmpty) {
// //       final address = addresses.first;
// //       setState(() {
// //         point = LatLng(address.coordinates.latitude, address.coordinates.longitude);
// //         location = [address];
// //       });
// //     }
// //   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             center: LatLng(30.3753, 69.3451),
//            // LatLng(49.5, -0.09),
//           onTap:(p)async{
//             location = await Geocoder.local.findAddressesFromCoordinates(
//                 Coordinates(p.latitude, p.longitude));
//
//             setState(() {
//               point = p as LatLng;
//               print(p);
//             });
//
//             print(
//                 "${location.isNotEmpty ? '${location.first.countryName}, ${location.first.locality}, ${location.first.featureName}' : ''}");
//           },
//             zoom: 5.0,
//           ),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: ['a', 'b', 'c'],
//             ),
//             MarkerLayerOptions(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: point,
//                   builder: (ctx) => Container(
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Card(
//                 child: TextField(
//                   onSubmitted: (query) {
//                     if (query.isNotEmpty) {
//                       searchLocation(query);
//                     }
//                   },
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(16.0),
//                     hintText: "Search for your location",
//                     prefixIcon: Icon(Icons.location_on_outlined),
//                   ),
//                 ),
//               ),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         location.isNotEmpty
//                             ? "${location.first.countryName}, ${location.first.locality}, ${location.first.featureName}"
//                             : "No location found",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
