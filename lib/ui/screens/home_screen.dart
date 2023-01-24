// ignore_for_file: invalid_use_of_visible_for_testing_member, deprecated_member_use

import 'dart:async';
import 'dart:math' as math;
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:waqoodi_client/preference.dart';
import 'package:waqoodi_client/ui/functions/functions.dart';
import 'package:waqoodi_client/ui/screens/login_screen.dart';
import 'package:waqoodi_client/ui/screens/profile_screen.dart';
import 'package:waqoodi_client/ui/screens/stations_screen.dart';

import '../../constrants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerList;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  late TabController _tabController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();
    _animationControllerList = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..forward();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() async {
        setState(() {});
        await _animationControllerList.reverse();
        _animationControllerList.forward(from: _animationControllerList.value);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, anim) {
            return Scaffold(
              extendBody: false,
              extendBodyBehindAppBar: true,
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors().primaryColor,
                    pinned: true,
                    expandedHeight: 217.h,
                    flexibleSpace: SafeArea(
                      child: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 20.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello , Ahmed',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    DateFormat('EEEE, DD MMMM yyyy')
                                        .format(DateTime.now()),
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.0.sp,
                                      color: Colors.white.withOpacity(0.7),
                                      height: 1.87.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizeTransition(
                                    sizeFactor: Tween(begin: 0.0, end: 1.0)
                                        .animate(CurvedAnimation(
                                            parent: _animationController,
                                            curve: Curves.easeInOutBack)),
                                    axis: Axis.horizontal,
                                    child: Container(
                                      color: Colors.white,
                                      width: 64.w,
                                      height: 6.h,
                                    ),
                                  ),
                                ],
                              ),
                              PopupMenuButton(
                                color: Colors.white,
                                onSelected: (value) async {
                                  if (value == 'log_out') {
                                    showDialog(
                                        context: context,
                                        builder: (c) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              elevation: 2.r,
                                              title: Text(
                                                'Are you sure to Log out?',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.0.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.0.sp,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await Preferences
                                                        .removeUserData();
                                                    navigateToScreen(context,
                                                        const LoginScreen(),
                                                        withRemoveUntil: true);
                                                  },
                                                  child: Text(
                                                    'Log out',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.0.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                  }else{
                                    navigateToScreen(context,
                                        const ProfileScreen());
                                  }
                                },
                                tooltip: 'Profile',
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                                itemBuilder: (BuildContext bc) {
                                  return [
                                    PopupMenuItem(
                                      value: '/profile',
                                      child: Text(
                                        'My Profile',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0.sp,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'log_out',
                                      child: Text(
                                        'Log out',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0.sp,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ];
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12.h),
                                  child: ClipOval(
                                    child: Image.asset('assets/logo.png',
                                        width: 34.w, height: 34.h),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(22.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 47.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0.r),
                                color: Colors.white.withOpacity(0.42),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  color: AppColors().primaryColor,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                                splashBorderRadius:
                                    BorderRadius.circular(12.0.r),
                                indicatorColor: Colors.white,
                                labelPadding:
                                    EdgeInsets.symmetric(vertical: 7.h),
                                tabs: [
                                  Text(
                                    'Pending',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Inprogress',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Done',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.h,
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              _animationController.value *
                                  MediaQuery.of(context).size.width,
                              _animationController.value * 100.0.r)),
                    ),
                  ),
                  SliverAppBar(
                    toolbarHeight: 51.h,
                    backgroundColor: Colors.transparent,
                    pinned: false,
                    flexibleSpace: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        navigateToScreen(context, const StationsScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 32.w),
                        child: Row(
                          children: [
                            Container(
                              width: 56.0,
                              height: 56.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors().primaryColor,
                              ),
                              child: Icon(
                                Icons.local_gas_station_rounded,
                                size: 27.r,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Hero(
                              tag: 'stations',
                              child: Text(
                                'Stations',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _listItems((_tabController.index + 1) * 6),
                ],
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
                          minimumSize: MaterialStatePropertyAll(
                              Size(double.infinity, 60.h)),
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors().primaryColor),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 8.h)),
                          tapTargetSize: MaterialTapTargetSize.padded),
                      onPressed: () {},
                      child: Text(
                        'Create New Order',
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

              // Column(
              //   children: [
              //     Expanded(
              //       child: TabBarView(
              //         controller: _tabController,
              //         children: [
              //           _listItems(10),
              //           _listItems(3),
              //           _listItems(5),
              //
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            );
          }),
    );
  }

  Widget _listItems(
    int count,
  ) =>
      SliverPadding(
        padding: EdgeInsets.only(
            right: 8.w,
            left: 8.w,
            bottom: 70.h + MediaQuery.of(context).viewPadding.bottom),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: count,
            (context, index) => ScaleTransition(
              scale: _animationControllerList,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                height: 85.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 1.0),
                      blurRadius: 4.0,
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, top: 8.h, bottom: 8.h, end: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'WayBill $index',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'date',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Gasoline',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '1,000 L',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Station Name',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '15,000 SR',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
