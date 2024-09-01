import 'dart:async';
import 'dart:convert';

import 'package:Quick_Power/bloc/general_states.dart';
import 'package:Quick_Power/constrants/colors.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/models/driver_location.dart';
import 'package:Quick_Power/repository/orders_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TrackingDriverScreen extends StatefulWidget {
  final String orderId;
  final LatLng clientLocation;
  final String stationName;
  final String waybillCode;

  const TrackingDriverScreen({Key? key, required this.orderId, required this.clientLocation, required this.stationName, required this.waybillCode})
      : super(key: key);

  @override
  State<TrackingDriverScreen> createState() => _TrackingDriverScreenState();
}

class _TrackingDriverScreenState extends State<TrackingDriverScreen> {
  late Timer timer;
  DriverLocation? driverLocation;
  late GoogleMapController mapController;
  late BitmapDescriptor driverIcon;
  late BitmapDescriptor clientIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24), devicePixelRatio: 0.4,),
        'assets/driver_location_icon.png')
        .then((onValue) {
      driverIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 20), devicePixelRatio: 0.4,),
        'assets/gas_station.png')
        .then((onValue) {
      clientIcon = onValue;
    });
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Future<void> startTimer() async {
    driverLocation = await OrdersRepo().getriverLocation(widget.orderId);
    setState(() {});

    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      // Inside the timer, perform the asynchronous operation and update the state
      driverLocation = await OrdersRepo().getriverLocation(widget.orderId);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().primaryColor,
          title: Text(
            '${Languages.of(context)?.trackingShipment} ${widget.waybillCode}',
            style: TextStyle(
              fontSize: 18.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12.0.r),
            ),
          ),
        ),
        backgroundColor: AppColors().backgroundColor,
        body: driverLocation?.data?.driverLocation?.longitude == null
            ? Center(
          child: CircularProgressIndicator(
            color: AppColors().primaryColor,
          ),
        )
            : GoogleMap(
          myLocationButtonEnabled: false,
          indoorViewEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              (driverLocation!.data!.driverLocation!.latitude + widget.clientLocation.latitude) / 2,
              (driverLocation!.data!.driverLocation!.longitude + widget.clientLocation.longitude) / 2,
            ),
            zoom: calculateZoomLevel(
              driverLocation!.data!.driverLocation!,
              widget.clientLocation,
            ),
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          markers: <Marker>{
            Marker(
              markerId: const MarkerId('driverLocation'),
              position: driverLocation!.data!.driverLocation!,
              icon: driverIcon,
              infoWindow: InfoWindow(title: Languages.of(context)!.driverLocation),
            ),
            Marker(
              markerId: const MarkerId('clientLocation'),
              position: widget.clientLocation,
              icon: clientIcon,
              infoWindow: InfoWindow(title: widget.stationName),
            ),
          },
          compassEnabled: true,
          myLocationEnabled: false,
          gestureRecognizers: Set()
            ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
        ),
      ),
    );
  }

  // Function to calculate zoom level based on distance between two points
  double calculateZoomLevel(LatLng driverLocation, LatLng clientLocation) {
    double zoom = 14.0;
    // Calculate distance between two points
    double distance = Geolocator.distanceBetween(driverLocation.latitude, driverLocation.longitude, clientLocation.latitude, clientLocation.longitude);
    // Adjust zoom level based on distance
    if (distance > 1000) {
      zoom = 10.0;
    } else if (distance > 500) {
      zoom = 12.0;
    } else if (distance > 200) {
      zoom = 14.0;
    }
    return zoom;
  }
}