import 'package:Quick_Power/ui/functions/functions.dart';
import 'package:Quick_Power/ui/screens/tracking_driver_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:Quick_Power/bloc/home/home_bloc.dart';
import 'package:Quick_Power/bloc/home/home_event.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/localization/LanguageHelper.dart';
import 'package:Quick_Power/models/order_details_model.dart';
import 'package:Quick_Power/ui/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/general_states.dart';
import '../../constrants/colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetails orderDetails;
  final bool cancelOption;
  final String? userName;
  const OrderDetailsScreen(
      {Key? key,
      required this.orderDetails,
      required this.cancelOption,
      this.userName})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            Languages.of(context)!.orderDetails,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12.0.r),
            ),
          ),
        ),
        body: BlocListener<HomeBloc, GeneralStates>(
          bloc: blocHome,
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context, true);
            }
          },
          child: BlocBuilder<HomeBloc, GeneralStates>(
              bloc: blocHome,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            widget.orderDetails.code ?? '',
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          Languages.of(context)!.orderStatus,
                          style: TextStyle(
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            widget.orderDetails.status!.name!,
                            style: TextStyle(
                              fontSize: 18.0.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              widget.orderDetails.status?.systemCode == '41006',
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 16.h),
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 34.w, vertical: 10.h)),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors().primaryColor),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ))),
                              onPressed: () {
                                navigateToScreen(
                                    context,
                                    TrackingDriverScreen(
                                      orderId:
                                          widget.orderDetails.id.toString(),
                                      clientLocation: LatLng(
                                          double.parse(widget
                                                  .orderDetails.location?.lat ??
                                              '0.0'),
                                          double.parse(widget
                                                  .orderDetails.location?.lon ??
                                              '0.0')),
                                      stationName:
                                          widget.orderDetails.location?.name ??
                                              '',
                                      waybillCode:
                                          widget.orderDetails.code ?? '',
                                    ),
                                    transitionDuration:
                                        const Duration(milliseconds: 0));
                              },
                              child: Text(
                                Languages.of(context)!.trackShipment,
                                style: TextStyle(
                                  fontSize: 15.0.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.recivedDate,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormat(
                                        'EEEE dd/MM/yyyy',
                                        LanguageHelper.isEnglish
                                            ? 'en_US'
                                            : 'ar_EG')
                                    .format(DateTime.parse(
                                        widget.orderDetails.date!)),
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.reciverName,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.userName ?? '',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.station,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.orderDetails.location!.name!,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.address,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.orderDetails.location?.address ?? '',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          Languages.of(context)!.invoiceDetails,
                          style: TextStyle(
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Table(
                          children: [
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[300]),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                          Languages.of(context)!.productType,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                          Languages.of(context)!.quantity,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text('سعر اللتر',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    widget.orderDetails.productType!.name!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(NumberFormat(
                                  "###,### ${Languages.of(context)!.l}",
                                  LanguageHelper.isEnglish ? 'en_US' : 'ar_EG',
                                ).format(double.parse(
                                    widget.orderDetails.quantity!))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${NumberFormat.currency(
                                    decimalDigits: 3,
                                    symbol: '')
                                    .format(double.tryParse(
                                    widget.orderDetails.itemPrice ??
                                        "0.0") ??
                                    0.0)} ${Languages.of(context)!.sar}'),
                              ),
                            ]),
                          ],
                          border:
                              TableBorder.all(color: Colors.black, width: 0.8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              'الاجمالى الفرعي : ',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${NumberFormat.currency(

                                      decimalDigits: 2,

                                      symbol: '')
                                  .format(double.tryParse(
                                          widget.orderDetails.totalPriceItem ??
                                              "0.0") ??
                                      0.0)} ${Languages.of(context)!.sar}',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if(widget.orderDetails.status?.id != 477 || ((widget.orderDetails.totalFeesWait??0) != 0))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'اجرة الشحن : ',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${NumberFormat.currency(
                                      decimalDigits: 2,
                                      symbol: '')
                                      .format(
                                      widget.orderDetails.totalFeesLoad ??
                                          "0.0")} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if((widget.orderDetails.totalFeesWait??0) != 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'اجرة الانتظار : ',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${NumberFormat.currency(
                                      decimalDigits: 2,
                                      symbol: '')
                                      .format(
                                      widget.orderDetails.totalFeesWait ??
                                          "0.0")} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if((widget.orderDetails.totalFeesDifference??0) != 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'فروقات التحميل : ',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${NumberFormat.currency(
                                      decimalDigits: 2,
                                      symbol: '')
                                      .format(
                                      widget.orderDetails.totalFeesDifference ??
                                          "0.0")} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'قيمة ضريبة القيمة المضافة : ',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                                Text(
                                  '${NumberFormat.currency(
                                      decimalDigits: 2,
                                      symbol: '')
                                      .format(
                                      widget.orderDetails.totalVat??
                                          "0.0")} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'الاجمالى شامل الضريبة : ',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                                Text(
                                  '${NumberFormat.currency(
                                      decimalDigits: 2,
                                      symbol: '')
                                      .format(
                                      widget.orderDetails.total??
                                          "0.0")} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if(widget.orderDetails.url != null)
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: (){
                                launchUrl(Uri.parse(widget.orderDetails.url??''));
                          },
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                )),
                                backgroundColor: MaterialStatePropertyAll(AppColors().primaryColor)
                                          ),child: Text('طباعة الفاتورة', style: TextStyle(
                            color: Colors.white
                          ), )),
                        ),
                        if( widget.orderDetails.status?.id == 477)
                        Text(
                          Languages.of(context)?.notePriceBefore ??'',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: AppColors().primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 12.h,
                        ),
                        Visibility(
                          visible: widget.orderDetails.truckCode != null,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context)!.truckInfo,
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.orderDetails.truckCode ?? '',
                                    style: TextStyle(
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              const Divider(),
                              Text(
                                Languages.of(context)!.driverInfo,
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.orderDetails.driver ?? '',
                                    style: TextStyle(
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.orderDetails.invoiceNo != null,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Languages.of(context)!.invoiceNo,
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                (widget.orderDetails.invoiceNo ?? '')
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        bottomSheet: Visibility(
          visible: widget.cancelOption,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0.r),
            ),
            child: Container(
              color: Colors.redAccent,
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
                      backgroundColor: const MaterialStatePropertyAll(
                        Colors.redAccent,
                      ),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 8.h)),
                      tapTargetSize: MaterialTapTargetSize.padded),
                  onPressed: () async {
                    print(Uri.parse(widget.orderDetails.url ?? '').toString());
                    if (widget.cancelOption) {
                      showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2.r,
                                title: Text(
                                  '${Languages.of(context)!.areYouSureToCancelOrder}\n${widget.orderDetails.code!}',
                                  style: TextStyle(
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
                                      Languages.of(context)!.no,
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      blocHome.add(CancelOrderEvent(
                                          id: widget.orderDetails.id!
                                              .toString()));
                                    },
                                    child: Text(
                                      Languages.of(context)!.yesCancel,
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                    } else if (widget.orderDetails.url != null) {
                      await launchUrl(Uri.parse(widget.orderDetails.url ?? ''));
                    }
                  },
                  child: Text(
                    widget.orderDetails.url == null
                        ? Languages.of(context)!.cancelOrder
                        : 'طباعة الفاتورة',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
