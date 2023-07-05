import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waqoodi_client/ui/functions/functions.dart';

import '../../constrants/colors.dart';
import '../../localization/Language/Languages.dart';
import '../../localization/LanguageHelper.dart';
import '../../models/stations_model.dart';
import 'maps_pick_location_screen.dart';

class AddNewStationScreen extends StatefulWidget {
  final Station? station;

  const AddNewStationScreen({Key? key, this.station}) : super(key: key);

  @override
  State<AddNewStationScreen> createState() => _AddNewStationScreenState();
}

class _AddNewStationScreenState extends State<AddNewStationScreen> {
  LatLng? latLng;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.station != null) {
      _nameController.text = widget.station!.name!;
      _addressController.text = widget.station!.locationDetails!;
      latLng = LatLng(double.parse(widget.station!.lat!),
          double.parse(widget.station!.lon!));
      _updatePlaceMark();
    }
  }

  Future<void> _updatePlaceMark() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng!.latitude, latLng!.longitude,
        localeIdentifier: LanguageHelper.isEnglish ? 'en' : 'ar');
    Placemark placeMark = placemarks[0];
    String? name = placeMark.street;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? country = placeMark.country;
    _locationController.text = "$name, $subLocality, $locality, $country";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  alignment: Alignment(-0.89.r, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0.r),
                    color: AppColors().backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 3.0.r),
                        blurRadius: 6.0.r,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    cursorColor: AppColors().primaryColor,
                    cursorHeight: 18.h,
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                      border: InputBorder.none,
                      hintText: Languages.of(context)!.name,
                      hintMaxLines: 1,
                      hintStyle: GoogleFonts.readexPro(
                        fontSize: 13.0.sp,
                        color: const Color(0xFF656565),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 3,
                    validator: (s) {
                      if (s!.isEmpty) {
                        return Languages.of(context)!.required;
                      }
                      return null;
                    },
                    style: GoogleFonts.readexPro(
                        fontSize: 14.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  alignment: Alignment(-0.89.r, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0.r),
                    color: AppColors().backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 3.0.r),
                        blurRadius: 6.0.r,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    cursorColor: AppColors().primaryColor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorHeight: 18.h,
                    controller: _addressController,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                      border: InputBorder.none,
                      hintText: Languages.of(context)!.address,
                      hintMaxLines: 1,
                      hintStyle: GoogleFonts.readexPro(
                        fontSize: 13.0.sp,
                        color: const Color(0xFF656565),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    minLines: 4,
                    maxLines: 5,
                    validator: (s) {
                      if (s!.isEmpty) {
                        return Languages.of(context)!.required;
                      }
                      return null;
                    },
                    style: GoogleFonts.readexPro(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  )),
              // Group: Group 62797
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  navigateToScreen(
                      context,
                      MapPickLocationScreen(
                        latLng: latLng,
                      )).then((value) async {
                    if (value != null) {
                      latLng = value;
                      _updatePlaceMark();
                    }
                  });
                },
                child: Container(
                    alignment: Alignment(-0.07.r, 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(0, 3.0.r),
                          blurRadius: 6.0.r,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      cursorColor: AppColors().primaryColor,
                      cursorHeight: 18.h,
                      enabled: false,
                      controller: _locationController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIconConstraints: BoxConstraints(
                          maxHeight: 18.0.h,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(end: 16.0.w, ),
                          child: SvgPicture.string(
                            '<svg viewBox="252.5 12.5 10.5 15.0" ><path transform="translate(245.0, 9.5)" d="M 12.75 3 C 9.847499847412109 3 7.5 5.347499847412109 7.5 8.25 C 7.5 12.1875 12.75 18 12.75 18 C 12.75 18 18 12.1875 18 8.25 C 18 5.347499847412109 15.65250015258789 3 12.75 3 Z M 12.75 10.125 C 11.71500015258789 10.125 10.875 9.284999847412109 10.875 8.25 C 10.875 7.215000152587891 11.71500015258789 6.375 12.75 6.375 C 13.78499984741211 6.375 14.625 7.215000152587891 14.625 8.25 C 14.625 9.284999847412109 13.78499984741211 10.125 12.75 10.125 Z" fill="#39969b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          ),
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                        border: InputBorder.none,
                        hintText: Languages.of(context)!.location,
                        hintMaxLines: 1,
                        hintStyle: GoogleFonts.readexPro(
                          fontSize: 13.0.sp,
                          color: const Color(0xFF656565),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      maxLines: 1,
                      validator: (s) {
                        if (s!.isEmpty) {
                          return Languages.of(context)!.required;
                        }
                        return null;
                      },
                      style: GoogleFonts.readexPro(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )
                    // SizedBox(
                    //   height: 16.0.h,
                    //   child: Row(
                    //     children: <Widget>[
                    //       SizedBox(width: 16.w,),
                    //       Expanded(
                    //         child: Text(
                    //           palaceMarkAddress??'Location',
                    //           overflow: TextOverflow.ellipsis,
                    //           style: GoogleFonts.readexPro(
                    //             fontSize: 12.0.sp,
                    //             color: const Color(0xFF656565),
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    //         child: SvgPicture.string(
                    //           // Icon material-location-on
                    //           '<svg viewBox="252.5 12.5 10.5 15.0" ><path transform="translate(245.0, 9.5)" d="M 12.75 3 C 9.847499847412109 3 7.5 5.347499847412109 7.5 8.25 C 7.5 12.1875 12.75 18 12.75 18 C 12.75 18 18 12.1875 18 8.25 C 18 5.347499847412109 15.65250015258789 3 12.75 3 Z M 12.75 10.125 C 11.71500015258789 10.125 10.875 9.284999847412109 10.875 8.25 C 10.875 7.215000152587891 11.71500015258789 6.375 12.75 6.375 C 13.78499984741211 6.375 14.625 7.215000152587891 14.625 8.25 C 14.625 9.284999847412109 13.78499984741211 10.125 12.75 10.125 Z" fill="#39969b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    //           width: 10.5,
                    //           height: 15.0,
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 34.w, vertical: 10.h)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors().primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(latLng!.latitude.toString());
                      Navigator.pop(
                          context,
                          Station(
                            name: _nameController.text.toString(),
                            lat: latLng!.latitude.toString(),
                            lon: latLng!.longitude.toString(),
                            locationDetails: _addressController.text.toString(),
                          ));
                    }
                  },
                  child: Text(
                    '${Languages.of(context)!.submit}${widget.station != null ?' ${Languages.of(context)!.edit}' : ''}',
                    style: GoogleFonts.readexPro(
                      fontSize: 15.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
