import 'dart:ui';

import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/models/create_order_model.dart';
import 'package:Quick_Power/ui/functions/functions.dart';
import 'package:Quick_Power/ui/screens/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../constrants/colors.dart';

Widget filedTextAuth(
        {String? hint,
        IconData? icon,
        bool isPassword = false,
        required TextEditingController controller,
        required TextInputType inputType,
        required TextInputAction textInputAction,
        Function? onSubmit,
        FocusNode? focusNode,
        bool? enabled,
        bool passwordVisible = true,
        Function()? onPasswordChange,
        List<TextInputFormatter>? inputFormatters,
        Widget? suffix,
        Widget? prefix,
        required String? Function(String?)? validator,
        String? errorText}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.disabled,
      textInputAction: textInputAction,
      validator: validator,
      focusNode: focusNode,
      obscureText: isPassword && !passwordVisible,
      autocorrect: false,
      inputFormatters: inputFormatters,
      enableSuggestions: true,
      textAlign: TextAlign.start,
      enabled: enabled,
      maxLines: 1,
      cursorColor: AppColors().primaryColor,
      autofocus: false,
      decoration: InputDecoration(
          suffixIcon: suffix,
          prefixStyle: TextStyle(
            fontSize: 18.0.sp,
            color: const Color(0xFF121214).withOpacity(0.56),
          ),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 15.w),
            child: prefix,
          ),
          hoverColor: AppColors().primaryColor,
          // control your hints text size
          isDense: false,
          suffix: isPassword
              ? GestureDetector(
                  onTap: onPasswordChange,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Icon(
                      passwordVisible!
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                )
              : null,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(
              maxWidth: 150.w,
              minWidth: 43.w,
              minHeight: 50.h,
              maxHeight: 50.h),
          hintStyle: TextStyle(
            fontSize: 18.0.sp,
            color: const Color(0xFF121214).withOpacity(0.56),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: AppColors().titleColor.withOpacity(0.75)),
          ),
          errorStyle: TextStyle(
            fontSize: 14.0.sp,
            color: Colors.red,
          ),
          focusColor: AppColors().primaryColor),
      style: TextStyle(
        fontSize: 18.0.sp,
        color: AppColors().titleColor,
      ),
    );

Widget filedText(
        {String? label,
        String? hint,
        IconData? icon,
        bool isPassword = false,
        required TextEditingController controller,
        required TextInputType inputType,
        required TextInputAction textInputAction,
        Function(String?)? onChange,
        Function? onSubmit,
        FocusNode? focusNode,
        bool? enabled,
        bool passwordVisible = true,
        Function()? onPasswordChange,
        List<TextInputFormatter>? inputFormatters,
        Widget? suffix,
        Widget? prefix,
        required String? Function(String?)? validator,
        String? errorText}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500,
              color: AppColors().titleColor,
            ),
          ),
        SizedBox(
          height: 8.h,
        ),
        Container(
            alignment: Alignment(-0.07.r, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 1.0.r),
                  blurRadius: 3.0.r,
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              onChanged: onChange,
              autovalidateMode: AutovalidateMode.disabled,
              textInputAction: textInputAction,
              validator: validator,
              focusNode: focusNode,
              obscureText: isPassword && !passwordVisible,
              autocorrect: false,
              inputFormatters: inputFormatters,
              enableSuggestions: true,
              textAlign: TextAlign.start,
              enabled: enabled,
              maxLines: 1,
              cursorColor: AppColors().primaryColor,
              autofocus: false,
              decoration: InputDecoration(
                  suffixIcon: suffix,
                  prefixStyle: TextStyle(
                    fontSize: 18.0.sp,
                    color: const Color(0xFF121214).withOpacity(0.56),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: prefix,
                  ),
                  hoverColor: AppColors().primaryColor,
                  // control your hints text size
                  isDense: false,
                  hintText: hint,
                  suffix: isPassword
                      ? GestureDetector(
                          onTap: onPasswordChange,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Icon(
                              passwordVisible!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        )
                      : null,
                  prefixIconConstraints: BoxConstraints(
                      maxWidth: 150.w,
                      minWidth: 43.w,
                      minHeight: 50.h,
                      maxHeight: 50.h),
                  hintStyle: TextStyle(
                    fontSize: 18.0.sp,
                    color: const Color(0xFF121214).withOpacity(0.56),
                  ),
                  border: InputBorder.none,
                  errorStyle: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.red,
                  ),
                  focusColor: AppColors().primaryColor),
              style: TextStyle(
                fontSize: 18.0.sp,
                color: AppColors().titleColor,
              ),
            )),
      ],
    );

Widget loadingWidget({Color? color}) => Center(
      child: SpinKitRing(
        color: color ?? AppColors().primaryColor,
        size: 50.0.sp,
        lineWidth: 3.r,
      ),
    );

Widget imageNetwork(String url, {BoxFit boxFit = BoxFit.cover}) =>
    CachedNetworkImage(
      imageUrl: url,
      fit: boxFit,
      placeholder: (
        context,
        url,
      ) =>
          loadingWidget(),
      errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
    );

Future<DateTime?> showCalendarDialog(
    BuildContext context, DateTime? selectedDate,
    {List<DateTime>? datesWithBadges,
    List<AvailabilityProduct>? availabilityProduct,
    required DateTime max,
    required DateTime min}) async {
  List<DateTime>? avilableDates =
      availabilityProduct?.map((e) => e.date!).toList();

  bool isDateEnabled(DateTime date) {
    return avilableDates?.any((enabledDate) =>
            enabledDate.year == date.year &&
            enabledDate.month == date.month &&
            enabledDate.day == date.day) ??
        false;
  }

  return await openDialog(
    context,
    (p0, p1, p2) => SizedBox(
      height: 620.h,
      child: SfCalendar(
        view: CalendarView.month,
        minDate: min,
        maxDate: max,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        dataSource: availabilityProduct != null
            ? _getCalendarDataSource(availabilityProduct)
            : null,
        allowViewNavigation: false,
        firstDayOfWeek: DateTime.saturday,
        todayTextStyle: Theme.of(context).textTheme.bodyLarge,
        todayHighlightColor: Colors.transparent,
        initialSelectedDate: selectedDate,
        allowAppointmentResize: true,
        initialDisplayDate: selectedDate,
        appointmentBuilder: (x, f) => Container(
          height: 15.h,
          color: f.appointments.first.color,
          child: Center(
            child: Text(
              f.appointments.first.subject,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ),
        blackoutDates: _getAllDates(min, max)
            .where((date) => !isDateEnabled(date))
            .toList(),
        onTap: (CalendarTapDetails s) {
          if (s.targetElement == CalendarElement.calendarCell) {
            Navigator.of(context).pop(s.date);
          }
        },
      ),
    ),
  );
}

List<DateTime> _getAllDates(DateTime startDate, DateTime endDate) {
  List<DateTime> dates = [];
  for (DateTime date = startDate;
      date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
      date = date.add(const Duration(days: 1))) {
    dates.add(date);
  }
  return dates;
}

_AppointmentDataSource _getCalendarDataSource(
    List<AvailabilityProduct> availabilityProduct) {
  List<Appointment> appointments = <Appointment>[];
  availabilityProduct.removeWhere(
      (element) => element.availabilityProductsDts?.isEmpty ?? true);
  for (AvailabilityProduct a in availabilityProduct) {
    a.availabilityProductsDts?.removeWhere(
        (element) => element.remainderTruck == 0 || element.remainderQty == 0);

    for (AvailabilityProductsDt p in a.availabilityProductsDts ?? []) {
      appointments.add(Appointment(
        startTime: a.date!,
        endTime: a.date!,
        subject: p.product?.name ?? '',
        color: getProductColor(p.product?.systemCode.toString() ?? ''),
        id: p.id.toString(),
      ));
    }
  }

  return _AppointmentDataSource(appointments);
}

Color getProductColor(String id) {
  switch (id) {
    case '77':
      return Colors.green;
    case '92':
      return Colors.red;
    case '76':
      return Colors.blueGrey;
    default:
      return Colors.blue;
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

Widget Function(BuildContext, Animation<double>, Animation<double>,
    Widget)? customTransitionDuration(
        {Color? backgroundColor, bool? noBack, EdgeInsets? edgeInsets}) =>
    (ctx, anim1, anim2, child) {
      return WillPopScope(
        onWillPop: () => Future(() => noBack ?? true),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: FadeTransition(
              opacity: anim1,
              child: SafeArea(
                child: Dialog(
                    backgroundColor: backgroundColor,
                    insetPadding: edgeInsets ??
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: child)),
              )),
        ),
      );
    };

void showLoginDialog(BuildContext context){
  openDialog(context, (a1,a2,d)=> Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(Languages.of(context)!.loginRequerdMessage, style: TextStyle(fontWeight: FontWeight.w700),),
        SizedBox(height: 8.h,),
        Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text(Languages.of(context)!.skip, style: const TextStyle(
            color: Colors.grey
          ),)),
          TextButton(onPressed: (){
            navigateToScreen(context, const LoginScreen());
          }, child: Text(Languages.of(context)!.signIn, style: TextStyle(
            color: AppColors().primaryColor
          ),)),
        ],),
      ],
    ),
  ));
}

Widget filedTextWidget({
  String? label,
  String? hint,
  IconData? icon,
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType inputType,
  required TextInputAction textInputAction,
  required BuildContext context,
  Function(String?)? onChange,
  Function(String)? onSubmit,
  FocusNode? focusNode,
  bool? enabled,
  bool passwordVisible = false,
  Function()? onPasswordChange,
  Color? bgColor,
  List<TextInputFormatter>? inputFormatters,
  Widget? prefix,
  String? suffixText,
  required String? Function(String?)? validation,
  String? errorText,
  int minLines = 1,
  int maxLines = 1,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
            child: Text(
              label ?? '',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              onChanged: onChange,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: textInputAction,
              validator: validation,

              focusNode: focusNode,
              obscureText: isPassword && !passwordVisible,
              autocorrect: false,
              inputFormatters: inputFormatters,
              enableSuggestions: true,
              textAlign: TextAlign.start,
              enabled: enabled,
              maxLines: maxLines,
              minLines: minLines,
              onFieldSubmitted: onSubmit,
              cursorColor: AppColors().primaryColor,
              autofocus: false,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.3.h,
                  ),
              decoration: InputDecoration(
                prefixIcon: prefix == null
                    ? null
                    : Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: prefix,
                      ),
                suffixText: suffixText,
                hoverColor: AppColors().primaryColor,
                hintText: hint,
                prefixIconConstraints: BoxConstraints(
                  maxWidth: 150.w,
                  minWidth: 43.w,
                  minHeight: 50.h,
                  maxHeight: 50.h,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.h),
                filled: true,
                fillColor: bgColor??Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ),
                suffix: isPassword
                    ? GestureDetector(
                        onTap: onPasswordChange,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      )
                    : null,
                focusColor: AppColors().primaryColor,
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
