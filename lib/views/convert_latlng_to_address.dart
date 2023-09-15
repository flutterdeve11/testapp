import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLngToAddress extends StatefulWidget {
  const ConvertLatLngToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLngToAddress> createState() => _ConvertLatLngToAddressState();
}

class _ConvertLatLngToAddressState extends State<ConvertLatLngToAddress> {

  String stAddress='';
  String stAdd='';
String cord ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
              //  Text('latitude: 37.597576, longitude: 55.771899'),
                //   Text(address),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: <Widget>[

                Center(child: Text("Address:  ${stAddress}")),
              ],


            ),

            ElevatedButton(
              onPressed: ()async {
                List<Placemark> placemarks = await placemarkFromCoordinates(35.3247, 75.5510);
                setState(() {
                  stAddress= placemarks.reversed.last.locality .toString()+ " "+placemarks.reversed.last.country.toString();
                 // stAddress= first.addressLine.toString();
                });
              },
              child: Text('Convert Coordinates to address'),
            ),


            Center(child: Text('This is log and lat of address ${stAdd}')),
            ElevatedButton(
              onPressed: ()async {
                // Action to perform when the button is pressed
                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                final query = "Plot B 238, Block 13D-1 Block 13 D 1 Gulshan-e-Iqbal, Karachi, Karachi City, Sindh, Pakistan";
               // var add = await Geocoder.local.findAddressesFromQuery(query);
             //   var second = add.first;
              //  print("${second.featureName} : ${second.coordinates}");
                setState(() {
                  stAdd=locations.last.longitude.toString()+ " "+locations.last.latitude.toString();
              //    cord= second.addressLine.toString();
                });

                // print('Button Pressed');
              },
              child: Text('Convert  address to  Coordinates  '),
            ),
            Stack(children: [    Container(
                width: 55.5,
                height: 48,
                decoration:     BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff32c6c3))
            ),
              Container(
                width: 24.571428298950195,
                height: 20,
              )],),
            Container(
                width: 327,
                height: 98,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Color(0xffaaafbb))
            )
          ],
        ),
      ),

    );
  }
}
