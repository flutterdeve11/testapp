import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller= Completer();
  TextEditingController _searchController = TextEditingController();
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );
  List<Marker> _marker=[];
  final List<Marker> _list= [

    Marker(markerId: MarkerId('1'),
    position:  LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(
        title: 'my postion'
      ),


    ),
    Marker(markerId: MarkerId('2'),
      position:  LatLng(33.7175, 73.0652),
      infoWindow: InfoWindow(
          title: 'my postion blue area'
      ),


    ),
    Marker(markerId: MarkerId('3'),
      position:  LatLng(33.738045, 73.084488),
      infoWindow: InfoWindow(
          title: 'my postion E sector'
      ),


    ),
    Marker(markerId: MarkerId('4'),
      position:  LatLng(24.9166, 67.0864),
      infoWindow: InfoWindow(
          title: 'Gulshan karachi'
      ),


    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    loadData();
  }

  loadData(){

  }
  Future<Position> getuserCurrentLocation()async{
 await  Geolocator.requestPermission().then((value){

 }).onError((error, stackTrace){
   print('error '+ error.toString());
 });
 return await Geolocator.getCurrentPosition();
  }
  LatLng _center = LatLng(33.6844, 73.0479);
  LatLng _selectedLocation =LatLng(33.6844, 73.0479);
  String _address = '';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 5.0,
              ),
              onTap: (LatLng p) async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  p.latitude,
                  p.longitude,
                );

                if (placemarks.isNotEmpty) {
                  setState(() {
                    _selectedLocation = p;
                    _address = placemarks[0].name!+ " " + placemarks[0].subAdministrativeArea!+ " " + placemarks[0].street!+ " " + placemarks[0].country!;
                    print(_address);
                  });
                }
              },
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId("selectedLocation"),
                  position: _selectedLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                ),
              ]),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller as Completer<GoogleMapController>;
              },
            ),

             Padding(
              padding: EdgeInsets.all(12.0),
              child: Card(
                child: TextField(
                 controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Search for your localisation",
                   suffixIcon: IconButton(onPressed: ()async{
                     String searchLocation = _searchController.text;
                     List<Location> locations = await locationFromAddress(searchLocation);
                      if (locations.isNotEmpty) {
                        setState(() {
                     _selectedLocation = LatLng(locations.first.latitude, locations.first.longitude);
                        _address = searchLocation;
                        print(_address);
                           });
                           }

                   }, icon: Icon(Icons.search),)
                   // prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
              ),
            ),
             Positioned(
               top: 590,
               child: Container(
                 height: 200,
                 width: 393,
                 decoration: BoxDecoration(
                     color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(20),
                     topRight: Radius.circular(20),
                   ),
                 ),
          child: Column(children: [
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Row(
                   children: [Text('Is this your location?',style: TextStyle(
                  fontSize: 16,
                   fontWeight: FontWeight.w900,
                     color: Colors.black
                 ),)],),
               ),

            ListTile(leading:Icon(Icons.pin_drop_sharp,color: Colors.red,),

            title: Text(_address,style: TextStyle(fontSize: 20),),),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color:  Color(0xFF32C6C3),
                  borderRadius: BorderRadius.all(
                  Radius.circular(20)
                  ),

                ),
           child: Text('Confirm Location',style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),




          ],),
               ),


               
             ),

          ],
          //children: [
          //   GoogleMap(
          //     initialCameraPosition: _kGooglePlex,
          //     // mapType: MapType.normal,
          //     // myLocationEnabled: true,
          //     markers: Set<Marker>.of(_marker),
          //     onMapCreated: (GoogleMapController controller){
          //       _controller.complete(controller);
          //     },
          //   ),
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          //     child: Column(children: [
          //       Card(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             border: InputBorder.none,
          //             contentPadding: EdgeInsets.all(16.0),
          //             hintText: "Search for your localisation",
          //             prefixIcon: Icon(Icons.location_on_outlined),
          //           ),
          //         ),
          //       ),
          //     ],),
          //   )
          //
          // ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(child: Icon(Icons.location_disabled_outlined),
      // onPressed: ()async{
      //   getuserCurrentLocation().then((value)async{
      //     print('my currnt loction');
      //     print(value.latitude.toString()+" "+value.longitude.toString());
      //     _marker.add(
      //       Marker(markerId: MarkerId('5'),
      //           position: LatLng(value.latitude,value.longitude),
      //           infoWindow: InfoWindow(
      //               title: 'my current loction'
      //           )
      //
      //       ),
      //
      //     );
      //     CameraPosition cameraPosition= CameraPosition(
      //       zoom: 14,
      //       target:LatLng(value.latitude,value.longitude),
      //
      //
      //     );
      //
      //     final  GoogleMapController controller=  await _controller.future;
      //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      //     setState(() {
      //
      //     });
      //   });
      //   //GoogleMapController controller= await _controller.future;
      //  // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(24.9166, 67.0864),zoom: 14 )));
      // },),
    );
  }
}
