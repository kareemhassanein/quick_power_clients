import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:waqoodi_client/bloc/home/home_bloc.dart';
import 'package:waqoodi_client/bloc/home/home_event.dart';
import 'package:waqoodi_client/localization/Language/Languages.dart';
import 'package:waqoodi_client/localization/LanguageHelper.dart';
import 'package:waqoodi_client/models/order_details_model.dart';
import 'package:waqoodi_client/ui/screens/home_screen.dart';

import '../../bloc/general_states.dart';
import '../../constrants/colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetails orderDetails;
  final bool cancelOption;
  const OrderDetailsScreen({Key? key, required this.orderDetails, required this.cancelOption})
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
            style: GoogleFonts.readexPro(
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
                if(widget.orderDetails.url != null){
                  return const PDF().cachedFromUrl(
                    widget.orderDetails.url.toString(),
                    placeholder: (progress) => Center(child: Text('$progress %')),
                    errorWidget: (error) => Center(child: Text(error.toString())),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.orderDetails.code ?? '',
                          style: GoogleFonts.readexPro(
                            fontSize: 20.0.sp,
                            color: const Color(0xFF404040),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.dueDate,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                DateFormat('EEEE dd/MM/yyyy', LanguageHelper.isEnglish? 'en_US' : 'ar_EG').format(
                                    DateTime.parse(widget.orderDetails.date!)),
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
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
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.orderDetails.location!.name!,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
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
                          style: GoogleFonts.readexPro(
                            fontSize: 20.0.sp,
                            color: const Color(0xFF404040),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                Languages.of(context)!.productType,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                widget.orderDetails.productType!.name!,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '',
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
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
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.quantity,
                                style: GoogleFonts.readexPro(
                                  fontSize: 15.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                NumberFormat(
                                  "###,### ${Languages.of(context)!.l}",
                                  LanguageHelper.isEnglish?'en_US' : 'ar_EG',
                                ).format(double.parse(
                                    widget.orderDetails.quantity!)),
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                Languages.of(context)!.total,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF404040),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                NumberFormat("###,### ${Languages.of(context)!.sar}", LanguageHelper.isEnglish ? 'en_US':'ar_EG').format(
                                    double.parse(widget.orderDetails.total!)),
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: AppColors().primaryColor,
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
                          Languages.of(context)!.orderStatus,
                          style: GoogleFonts.readexPro(
                            fontSize: 20.0.sp,
                            color: const Color(0xFF404040),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          widget.orderDetails.status!.name!,
                          style: GoogleFonts.readexPro(
                            fontSize: 16.0.sp,
                            color: const Color(0xffEDD236),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        bottomSheet: widget.orderDetails.url != null ? null : ClipRRect(
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
                    minimumSize: MaterialStatePropertyAll(
                        Size(double.infinity, 60.h)),
                    backgroundColor: const MaterialStatePropertyAll(
                  Colors.redAccent,
                    ),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8.h)),
                    tapTargetSize: MaterialTapTargetSize.padded),
                onPressed: () {
                  if(widget.cancelOption) {
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(12.r),
                          ),
                          elevation: 2.r,
                          title: Text(
                            '${Languages.of(context)!.areYouSureToCancelOrder}\n${widget.orderDetails.code!}',
                            style:
                            GoogleFonts.readexPro(
                              fontSize: 16.0.sp,
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context);
                              },
                              child: Text(
                                Languages.of(context)!.no,
                                style: GoogleFonts
                                    .readexPro(
                                  fontSize: 14.0.sp,
                                  color: Colors
                                      .black87,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                blocHome.add(CancelOrderEvent(id: widget.orderDetails.id!.toString()));
                              },
                              child: Text(
                                Languages.of(context)!.yesCancel,
                                style: GoogleFonts
                                    .readexPro(
                                  fontSize: 14.0.sp,
                                  fontWeight:
                                  FontWeight
                                      .w500,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ));
                  }
                },
                child: Text(
                  Languages.of(context)!.cancelOrder,
                  style: GoogleFonts.readexPro(
                    fontSize: 16.0.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
