import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/ui/widgets/widgets.dart';

import '../../constrants/colors.dart';

class MapPickLocationScreen extends StatefulWidget {
  final LatLng? latLng;
  const MapPickLocationScreen({Key? key, this.latLng}) : super(key: key);

  @override
  State<MapPickLocationScreen> createState() => _MapPickLocationScreenState();
}

class _MapPickLocationScreenState extends State<MapPickLocationScreen> {
  late GoogleMapController mapController;
  String? address;
  LatLng? _currentPosition;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.latLng == null;
    if (widget.latLng == null) {
      getLocation();
    }
  }


  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  getLocation() async {
    setState(() {
      _isLoading = true;
    });
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 15.8,)));
    setState(() {
      _isLoading = false;
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (widget.latLng != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: widget.latLng!, zoom: 15.8,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
        backgroundColor: AppColors().primaryColor,
        title: Text(
          Languages.of(context)!.stationLocation,
          style: GoogleFonts.readexPro(
            fontSize: 16.0.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [IconButton(onPressed: () async {
          Navigator.pop(context, await mapController.getLatLng(ScreenCoordinate(x: middleX.round(), y: middleY.round())));
        }, icon: const Icon(Icons.done_rounded, color: Colors.white,))],
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.0.r),
          ),
        ),
      ),
      body:
      Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.5265491, 45.0012263),
              zoom: 5.5,
            ),
          ),

      Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 62.h),
          child: SvgPicture.string(
            '<svg viewBox="293.22 376.73 8.87 15.77" ><path transform="translate(293.22, 376.73)" d="M 3.450426578521729 9.764090538024902 L 3.450426578521729 14.59129905700684 L 4.128804683685303 15.60855865478516 C 4.275139808654785 15.82790851593018 4.597692966461182 15.82790851593018 4.744028091430664 15.60855865478516 L 5.422099113464355 14.59129905700684 L 5.422099113464355 9.764090538024902 C 5.102009773254395 9.823241233825684 4.773295402526855 9.85836124420166 4.436262607574463 9.85836124420166 C 4.099230289459229 9.85836124420166 3.770515203475952 9.823241233825684 3.450426578521729 9.764090538024902 Z M 4.436262607574463 0 C 1.986151695251465 0 0 1.986151695251465 0 4.436262607574463 C 0 6.886373519897461 1.986151695251465 8.872525215148926 4.436262607574463 8.872525215148926 C 6.886373519897461 8.872525215148926 8.872525215148926 6.886373519897461 8.872525215148926 4.436262607574463 C 8.872525215148926 1.986151695251465 6.886373519897461 0 4.436262607574463 0 Z M 4.436262607574463 2.341361045837402 C 3.280986070632935 2.341361045837402 2.341361045837402 3.280986070632935 2.341361045837402 4.436262607574463 C 2.341361045837402 4.640207767486572 2.175617218017578 4.805951118469238 1.971672177314758 4.805951118469238 C 1.767727375030518 4.805951118469238 1.601983666419983 4.640207767486572 1.601983666419983 4.436262607574463 C 1.601983666419983 2.873404502868652 2.873712539672852 1.601983666419983 4.436262607574463 1.601983666419983 C 4.640207767486572 1.601983666419983 4.805951118469238 1.767727375030518 4.805951118469238 1.971672177314758 C 4.805951118469238 2.175617218017578 4.640207767486572 2.341361045837402 4.436262607574463 2.341361045837402 Z" fill="#215f92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
            height: 62.w,
          ),
        ),
      )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Padding(
        padding:  EdgeInsetsDirectional.only(bottom: 24.h, start: 8.w),
        child: FloatingActionButton(

          onPressed: () {
            getLocation();
          },
          backgroundColor: AppColors().primaryColor,
          child: _isLoading
              ? Container(
            width: 24.r,
            height: 24.r,
            padding:  EdgeInsets.all(2.0.r),
            child:  loadingWidget(color: Colors.white)
          )
              : const Icon(Icons.location_on),
        ),
      ),
    );
  }
}
