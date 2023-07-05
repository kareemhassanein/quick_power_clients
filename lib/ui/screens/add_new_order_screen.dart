import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:waqoodi_client/bloc/home/home_bloc.dart';
import 'package:waqoodi_client/localization/Language/Languages.dart';
import 'package:waqoodi_client/localization/LanguageHelper.dart';
import 'package:waqoodi_client/models/create_order_model.dart';
import 'package:waqoodi_client/models/post_order_model.dart';
import 'package:waqoodi_client/ui/functions/functions.dart';
import 'package:waqoodi_client/ui/screens/home_screen.dart';

import '../../bloc/general_states.dart';
import '../../bloc/home/home_event.dart';
import '../../constrants/colors.dart';

class AddNewOrderScreen extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const AddNewOrderScreen({Key? key, required this.createOrderModel}) : super(key: key);

  @override
  State<AddNewOrderScreen> createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen> {
  late DateTime? dateTime;
  final TextEditingController _quantityController = MoneyMaskedTextController(precision: 0, decimalSeparator: '', thousandSeparator: ',')..text = '0.0';
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ProductType selectedPaymentMethod;
  late ProductType selectedStation;
  late ProductType selectedProductType;

  @override
  void initState() {
    selectedProductType = widget.createOrderModel.data!.productTypes!.first;
    selectedPaymentMethod = widget.createOrderModel.data!.paymentMethods!.first;
    selectedStation = widget.createOrderModel.data!.locations!.first;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocListener<HomeBloc, GeneralStates>(
          bloc: blocHome,
  listener: (context, state) {
            if(state is SuccessState){
              Navigator.pop(context, true);
            }
  },
  child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    dateTime = await selectDate(context);
                    if(dateTime != null) {
                      _dateController.text = DateFormat('EEEE, dd/MM/yyyy', LanguageHelper.isEnglish?'en' :'ar')
                          .format(dateTime!);
                    }
                  },
                  child: Container(
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
                        enabled: false,
                        cursorColor: AppColors().primaryColor,
                        cursorHeight: 18.h,
                        controller: _dateController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.calendar_month_rounded, color: AppColors().primaryColor,),
                          hintText: Languages.of(context)!.date,
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
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    child: DropdownButton<ProductType>(
                      borderRadius: BorderRadius.circular(7.0.r),
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      elevation: 2.r.toInt(),
                      value: selectedProductType,
                      hint: Text(Languages.of(context)!.productDetails, style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),),
                      isDense: false,
                      items: widget.createOrderModel.data!.productTypes!.map((ProductType value) {
                        return DropdownMenuItem<ProductType>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value.name!),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Text('${NumberFormat("###,###0.00 ${Languages.of(context)!.sar}", LanguageHelper.isEnglish? "en_US" : 'ar_EG').format(
                                       value.unitPrice!)} / ${Languages.of(context)!.l}', style: GoogleFonts.readexPro(
                                    fontSize: 13.0.sp,
                                    color: AppColors().primaryColor,),),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (_) {
                        if(_!= null) {
                          setState(() {
                            selectedProductType = _;
                          });
                        }
                      },
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
                      cursorHeight: 18.h,
                      controller: _quantityController,
                      autovalidateMode: AutovalidateMode.disabled,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                        isCollapsed: true,
                        suffix: Text(Languages.of(context)!.l,style: GoogleFonts.readexPro(
                            fontSize: 14.0.sp,
                            color: AppColors().primaryColor,
                            fontWeight: FontWeight.w500)),
                        contentPadding: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                        border: InputBorder.none,
                        hintText: Languages.of(context)!.quantity,
                        hintMaxLines: 1,
                        hintStyle: GoogleFonts.readexPro(
                          fontSize: 13.0.sp,
                          color: const Color(0xFF656565),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      minLines: 1,
                      onChanged: (s){
                        if(s == '0'){
                          _quantityController.text = '';
                        }
                        else if(int.parse(s.replaceAll(',', '')) > 50000){
                          _quantityController.text = '50,000';
                        }
                        setState(() {

                        });
                      },
                      maxLines: 3,
                      validator: (s) {
                        if (s!.isEmpty) {
                          return Languages.of(context)!.required;
                        }else if(int.parse(s.replaceAll(',', '')) < 10000){
                          return 'Minimum 10,000';
                        }else if(int.parse(s.replaceAll(',', '')) > 50000){
                          return 'Maximum 50,000';
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    child: DropdownButton<ProductType>(
                      borderRadius: BorderRadius.circular(7.0.r),
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      elevation: 2.r.toInt(),
                      value: selectedStation,
                      icon: Icon(CupertinoIcons.location_solid, color: AppColors().primaryColor,),
                      hint: Text(Languages.of(context)!.stations, style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),),
                      isDense: false,
                      items: widget.createOrderModel.data!.locations!.map((ProductType value) {
                        return DropdownMenuItem<ProductType>(
                          value: value,
                          child: Text(value.name!),
                        );
                      }).toList(),
                      onChanged: (_) {
                        if(_!= null) {
                          setState(() {
                            selectedStation = _;
                          });
                        }
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    child: DropdownButton<ProductType>(
                      borderRadius: BorderRadius.circular(7.0.r),
                      underline: const SizedBox(),
                      isExpanded: true,
                      style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      elevation: 2.r.toInt(),
                      value: selectedPaymentMethod,
                      hint: Text('Payment Method', style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),),
                      isDense: false,
                      items: widget.createOrderModel.data!.paymentMethods!.map((ProductType value) {
                        return DropdownMenuItem<ProductType>(
                          value: value,
                          child: Text(value.name!),
                        );
                      }).toList(),
                      onChanged: (_) {
                        if(_!= null) {
                          setState(() {
                            selectedPaymentMethod = _;
                          });
                        }
                      },
                    )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Languages.of(context)!.subTotal,
                      style: GoogleFonts.readexPro(
                        fontSize: 15.0.sp,
                        color: const Color(0xFF656565),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '${NumberFormat.currency(symbol: '', locale: LanguageHelper.isEnglish ? 'en_US':'ar_EG').format(getTotal(
                            unitPrice: selectedProductType.unitPrice, quantity: _quantityController.text))} ${Languages.of(context)!.sar}',
                        style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: AppColors().primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${NumberFormat.compact(locale: LanguageHelper.isEnglish ? 'en_US':'ar_EG').format(double.parse(widget.createOrderModel.data!.vat!)*100)}% ${Languages.of(context)!.vat}',
                      style: GoogleFonts.readexPro(
                        fontSize: 15.0.sp,
                        color: const Color(0xFF656565),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '${NumberFormat.currency(symbol: '',locale: LanguageHelper.isEnglish ? 'en_US':'ar_EG').format(getTotal(
                            unitPrice: selectedProductType.unitPrice, quantity: _quantityController.text) * double.parse(widget.createOrderModel.data!.vat!))} ${Languages.of(context)!.sar}',
                        style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: AppColors().primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Languages.of(context)!.total,
                      style: GoogleFonts.readexPro(
                        fontSize: 15.0.sp,
                        color: const Color(0xFF656565),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '${NumberFormat.currency(symbol: '',locale: LanguageHelper.isEnglish ? 'en_US':'ar_EG').format(getTotal( unitPrice: selectedProductType.unitPrice, quantity: _quantityController.text)+  getTotal(
                            unitPrice: selectedProductType.unitPrice, quantity: _quantityController.text) * double.parse(widget.createOrderModel.data!.vat!))} ${Languages.of(context)!.sar}',
                        style: GoogleFonts.readexPro(
                          fontSize: 14.0.sp,
                          color: AppColors().primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height: 8.h,),
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
                        blocHome.add(StoreOrderEvent(data: {
                          'quantity': _quantityController.text.replaceAll(',', ''),
                        'date':DateFormat('yyyy-MM-dd').format(dateTime!),
                        'product_type_id' : selectedProductType.id!.toString(),
                        'payment_method_id':selectedPaymentMethod.id!.toString(),
                        'user_location_id': selectedStation.id!.toString(),
                        }));
                      }
                    },
                    child: Text(
                      Languages.of(context)!.submit,
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
      ),
),
    );
  }
}
