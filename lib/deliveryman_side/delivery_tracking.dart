import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  const DeliveryTrackingScreen({super.key});

  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  late GoogleMapController mapController;
  Location location = Location();
  LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  final LatLng _destinationPosition = const LatLng(37.7749, -122.4194);
  bool _isDeliveryStarted = false;

  @override
  void initState() {
    super.initState();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _initialPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
      mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _startDelivery() {
    setState(() {
      _isDeliveryStarted = true;
    });
  }

  void _markAsDelivered() {
    setState(() {
      _isDeliveryStarted = false;
    });
    // Perform any additional logic for marking as delivered
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Tracking'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: _initialPosition,
                ),
                Marker(
                  markerId: const MarkerId('destinationLocation'),
                  position: _destinationPosition,
                ),
              },
            ),
          ),
          if (!_isDeliveryStarted)
            ElevatedButton(
              onPressed: _startDelivery,
              child: const Text('Start Delivery'),
            ),
          if (_isDeliveryStarted)
            ElevatedButton(
              onPressed: _markAsDelivered,
              child: const Text('Mark as Delivered'),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DeliveryTrackingScreen(),
    );
  }
}
