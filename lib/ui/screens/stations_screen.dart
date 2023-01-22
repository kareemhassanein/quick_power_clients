import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqoodi_client/bloc/general_states.dart';
import 'package:waqoodi_client/bloc/stations/stations_bloc.dart';
import 'package:waqoodi_client/bloc/stations/stations_event.dart';
import 'package:waqoodi_client/constrants/colors.dart';
import 'package:waqoodi_client/models/stations_model.dart';
import 'package:waqoodi_client/ui/screens/add_new_station_screen.dart';
import 'package:waqoodi_client/ui/widgets/widgets.dart';

import '../functions/functions.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen> {
  final StationsBloc bloc = StationsBloc()..add(GetStationsEvent());

  @override
  Widget build(BuildContext context) {
    List<Station>? stations;

    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      body: BlocBuilder<StationsBloc, GeneralStates>(
        bloc: bloc,
        builder: (context, state) {
          if(state is SuccessState){
            stations = state.response!.data!;
          }
          return CustomScrollView(
            scrollBehavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors().primaryColor,
                pinned: true,
                title: Hero(
                  tag: 'stations',
                  child: Text(
                    'Stations',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.0.r),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                    top: 16.h,
                    right: 8.w,
                    left: 8.w,
                    bottom: 70.h + MediaQuery.of(context).viewPadding.bottom),
                sliver: stations == null ? SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: loadingWidget(),
                ) :
                LiveSliverList(
                  itemCount: stations!.length,
                  controller: ScrollController(),
                  delay: Duration.zero,
                  reAnimateOnVisibility: false,
                  showItemInterval: const Duration(milliseconds: 50),
                  showItemDuration: const Duration(milliseconds: 250),
                  itemBuilder: (context, index, anim) => ScaleTransition(
                    scale: anim,
                    child: GestureDetector(
                      onTap: (){
                        openMap(double.parse(stations![index].lat!), double.parse(stations![index].lon!));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        height: 70.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 1.0.r),
                              blurRadius: 4.0.r,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12.0.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10.0.r),
                                ),
                                color: AppColors().primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stations![index].name!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Expanded(
                                      child: Text(
                                        stations![index].locationDetails!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.0.sp,
                                      color: AppColors().primaryColor,
                                    ),
                                  ))
                                ],
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w,
                              ),
                              child: SvgPicture.string(
                                '<svg viewBox="339.69 129.0 20.9 20.9" ><path transform="translate(336.68, 126.0)" d="M 23.60771369934082 12.7103796005249 L 14.19935512542725 3.302021026611328 C 13.79166030883789 2.894325733184814 13.13307476043701 2.894325733184814 12.72537994384766 3.302021026611328 L 3.317020416259766 12.7103796005249 C 2.909324884414673 13.11807537078857 2.909324884414673 13.77666091918945 3.317020416259766 14.18435573577881 L 12.72537994384766 23.59271430969238 C 13.13307476043701 24.00041007995605 13.79166030883789 24.00041007995605 14.19935512542725 23.59271430969238 L 23.60771369934082 14.18435573577881 C 24.01540756225586 13.78711414337158 24.01540756225586 13.12852954864502 23.60771369934082 12.7103796005249 Z M 15.54788780212402 16.0660285949707 L 15.54788780212402 13.45259571075439 L 11.36639499664307 13.45259571075439 L 11.36639499664307 16.58871459960938 L 9.275649070739746 16.58871459960938 L 9.275649070739746 12.40722179412842 C 9.275649070739746 11.83226680755615 9.746067047119141 11.36184883117676 10.32102203369141 11.36184883117676 L 15.54788780212402 11.36184883117676 L 15.54788780212402 8.748415946960449 L 19.20669364929199 12.40722179412842 L 15.54788780212402 16.0660285949707 Z" fill="#edd236" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                width: 20.9,
                                height: 20.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
      bottomSheet: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0.r),
        ),
        child: Container(
          color: AppColors().primaryColor,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.white.withOpacity(0.15)),
                  splashFactory: InkSparkle.splashFactory,
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 60.h)),
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors().primaryColor),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8.h)),
                  tapTargetSize: MaterialTapTargetSize.padded),
              onPressed: () {
                openDialog(context, (p0, p1, p2) => const AddNewStationScreen());
              },
              child: Text(
                'Add New Station',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
