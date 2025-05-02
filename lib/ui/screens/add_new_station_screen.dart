import 'package:Quick_Power/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Quick_Power/ui/functions/functions.dart';

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
      latLng!.latitude,
      latLng!.longitude,
    );
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
              filedTextWidget(
                context: context,
                label: '*${Languages.of(context)!.name}',
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                controller: _nameController,
                inputType: TextInputType.name,
                textInputAction: TextInputAction.done,
                minLines: 1,
                maxLines: 3,
                validation: (s) {
                  if (s!.isEmpty) {
                    return Languages.of(context)!.required;
                  }
                  return null;
                },
              ),
              filedTextWidget(
                context: context,
                label: '*${Languages.of(context)!.address}',
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                controller: _addressController,
                inputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.done,
                validation: (s) {
                  if (s!.isEmpty) {
                    return Languages.of(context)!.required;
                  }
                  return null;
                },
              ),
              GestureDetector(
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
                child: filedTextWidget(
                  context: context,
                  enabled: false,
                  label: '*${Languages.of(context)!.location}',
                  bgColor: Theme.of(context).scaffoldBackgroundColor,
                  controller: _locationController,
                  inputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 5,
                  validation: (s) {
                    if (s!.isEmpty && widget.station == null) {
                      return Languages.of(context)!.required;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
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
                    '${Languages.of(context)!.submit}${widget.station != null ? ' ${Languages.of(context)!.edit}' : ''}',
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
