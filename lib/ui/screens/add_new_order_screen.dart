import 'package:Quick_Power/bloc/stations/stations_bloc.dart';
import 'package:Quick_Power/bloc/stations/stations_event.dart';
import 'package:Quick_Power/models/stations_model.dart';
import 'package:Quick_Power/ui/widgets/date_picker_widget.dart';
import 'package:Quick_Power/ui/widgets/dropdown_cus.dart';
import 'package:Quick_Power/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:Quick_Power/bloc/home/home_bloc.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/localization/LanguageHelper.dart';
import 'package:Quick_Power/models/create_order_model.dart';
import 'package:Quick_Power/models/post_order_model.dart';
import 'package:Quick_Power/ui/functions/functions.dart';
import 'package:Quick_Power/ui/screens/add_new_station_screen.dart';
import 'package:Quick_Power/ui/screens/home_screen.dart';

import '../../bloc/general_states.dart';
import '../../bloc/home/home_event.dart';
import '../../constrants/colors.dart';

class AddNewOrderScreen extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const AddNewOrderScreen({Key? key, required this.createOrderModel})
      : super(key: key);

  @override
  State<AddNewOrderScreen> createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen> {
  DateTime? dateTime;
  final TextEditingController _quantityController = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',')
    ..text = '0.0';
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ProductType? selectedPaymentMethod;
  Station? selectedStation;
  ProductType? selectedProductType;
  final StationsBloc blocStations = StationsBloc();
  FocusNode focusNode = FocusNode();
  late DateTime minDate;
  late DateTime maxDate;
  List<ProductType> avilableProducts = [];
  int avilableQty = 0;

  @override
  void initState() {
    super.initState();
    minDate = widget.createOrderModel.data!.availabilityProducts!
        .map((e) => e.date!)
        .toList()
        .reduce((a, b) => a.isBefore(b) ? a : b);
    maxDate = widget.createOrderModel.data!.availabilityProducts!
        .map((e) => e.date!)
        .toList()
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors().primaryColor,
          title: Text(
            Languages.of(context)!.addNewStation,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.0.r),
            ),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocListener<HomeBloc, GeneralStates>(
            bloc: blocHome,
            listener: (context, state) {
              if (state is SuccessState) {
                Navigator.pop(context, true);
              }
            },
            child: BlocListener<StationsBloc, GeneralStates>(
                bloc: blocStations,
                listener: (context, state) {
                  if (state is SuccessState) {
                    if (state.response != null) {
                      setState(() {
                        widget.createOrderModel.data!.locations =
                            state.response!.data!;
                        if (widget.createOrderModel.data!.locations != null &&
                            widget
                                .createOrderModel.data!.locations!.isNotEmpty) {
                          selectedStation =
                              widget.createOrderModel.data!.locations?.last;
                        }
                      });
                    }
                  }
                },
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DatePickerWidget(
                          selectedDateTime: dateTime,
                          availabilityProduct: widget
                              .createOrderModel.data?.availabilityProducts,
                          validation: (s) {
                            if (dateTime == null) {
                              return Languages.of(context)!.required;
                            }
                            return null;
                          },
                          onChanged: (date) {
                            if (date != null) {
                              selectedProductType = null;
                              setState(() {
                                dateTime = date;
                                avilableProducts.clear();
                                avilableProducts.addAll(widget
                                        .createOrderModel.data?.productTypes ??
                                    []);
                                avilableProducts.removeWhere((element) =>
                                    !(widget.createOrderModel.data
                                            ?.availabilityProducts
                                            ?.firstWhere((el) => (el.date
                                                    ?.isAtSameMomentAs(date) ??
                                                false))
                                            .availabilityProductsDts
                                            ?.any((e) => ((e.product!.id! ==
                                                    element.id) &&
                                                e.remainderQty != 0 &&
                                                e.remainderTruck != 0)) ??
                                        false));
                              });
                            }
                            return null;
                          },
                          minDateTime: minDate,
                          maxDateTime: maxDate,
                          label: '*${Languages.of(context)?.deliveryDate}',
                        ),
                        GestureDetector(
                          onTap: dateTime == null
                              ? () {
                                  Fluttertoast.showToast(
                                      msg: 'برجاء اختيار تاريخ الاستلام أولاُ');
                                }
                              : null,
                          behavior: HitTestBehavior.translucent,
                          child: DropdownCus(
                            title: '*${Languages.of(context)!.productType}',
                            items: avilableProducts,
                            selected: selectedProductType,
                            enabled: dateTime != null,
                            hintSearch: '',
                            withSearch: false,
                            validation: (s) {
                              if (selectedProductType == null) {
                                return Languages.of(context)!.required;
                              }
                              return null;
                            },
                            itemBuilder: (c, e, b) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 24.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: e == selectedProductType,
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: AppColors().primaryColor,
                                        ),
                                      ),
                                      Text(
                                        e?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: Text(
                                      '${NumberFormat("###,###0.00 ${Languages.of(context)!.sar}", LanguageHelper.isEnglish ? "en_US" : 'ar_EG').format(e.unitPrice ?? 0)} / ${Languages.of(context)!.l}',
                                      style: TextStyle(
                                        fontSize: 13.0.sp,
                                        color: AppColors().primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onChanged: (s) {
                              setState(() {
                                selectedProductType = s;
                                _quantityController.text = '0';
                                avilableQty = widget.createOrderModel.data
                                        ?.availabilityProducts
                                        ?.firstWhere((el) => (el.date
                                                ?.isAtSameMomentAs(dateTime!) ??
                                            false))
                                        .availabilityProductsDts
                                        ?.firstWhere((element) =>
                                            element.product?.id == s.id)
                                        .remainderQty ??
                                    0;
                              });
                            },
                          ),
                        ),

                        Visibility(
                          visible: avilableQty != 0,
                          child:  Padding(padding: EdgeInsets.only(bottom: 16.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(' الكمية المتاحة للمنتج : ${NumberFormat(
                                "###,###",
                                LanguageHelper.isEnglish ? 'en_US' : 'ar_EG',
                              ).format(avilableQty)} ${Languages.of(context)!.l}'),
                            ),)
                        ),

                        filedTextWidget(
                            context: context,
                            label: '*${Languages.of(context)!.quantity}',
                            onChange: (s) {
                              if (s == '') {
                                _quantityController.text = '0';
                              }
                              focusNode.notifyListeners();
                              setState(() {});
                            },
                            controller: _quantityController,
                            inputType: TextInputType.number,
                            suffixText: Languages.of(context)!.l,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            textInputAction: TextInputAction.done,
                            validation: (s) {
                              if (s!.isEmpty) {
                                return Languages.of(context)!.required;
                              } else {
                                if (int.parse(s.replaceAll(',', '')) < 10000) {
                                  return 'Minimum 10,000';
                                }
                                
                                if (int.parse(s.replaceAll(',', '')) >
                                    avilableQty) {
                                  return 'Maximum ${NumberFormat('###,###').format(avilableQty)}';
                                }

                              }
                              return null;
                            }),
                        DropdownCus(
                          title: '*${Languages.of(context)!.deliveryAddress}',
                          items: [
                            ...(widget.createOrderModel.data?.locations ?? []),
                            Station(
                              id: -500,
                              name: 'dd',
                            )
                          ],
                          selected: selectedStation,
                          hintSearch: 'بحث',
                          withSearch:
                              (widget.createOrderModel.data?.locations ?? [])
                                      .length >
                                  7,
                          validation: (s) {
                            if (selectedStation == null) {
                              return Languages.of(context)!.required;
                            }
                            return null;
                          },
                          itemBuilder: (c, e, b) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.w),
                            child: e.id != -500
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 275.w,
                                        child: Text(
                                          e?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Visibility(
                                        visible: e == selectedStation,
                                        child: const Icon(Icons.check_rounded),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Languages.of(context)!.addNewStation,
                                        style: TextStyle(
                                            color: AppColors().primaryColor),
                                      ),
                                      Icon(
                                        Icons.add_rounded,
                                        color: AppColors().primaryColor,
                                      )
                                    ],
                                  ),
                          ),
                          onChanged: (s) {
                            if (s.id == -500) {
                              openDialog(
                                      context,
                                      (p0, p1, p2) =>
                                          const AddNewStationScreen())
                                  .then((value) {
                                if (value != null) {
                                  blocStations
                                      .add(AddNewStationEvent(value.toJson()));
                                }
                              });
                            } else {
                              setState(() {
                                selectedStation = s;
                              });
                            }
                          },
                        ),
                        DropdownCus(
                          title: '*${Languages.of(context)!.paymentMethod}',
                          items: widget.createOrderModel.data?.paymentMethods ??
                              [],
                          selected: selectedPaymentMethod,
                          withSearch: false,
                          validation: (s) {
                            if (selectedPaymentMethod == null) {
                              return Languages.of(context)!.required;
                            }
                            return null;
                          },
                          onChanged: (s) {
                            setState(() {
                              selectedPaymentMethod = s;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Languages.of(context)!.subTotal,
                                style: TextStyle(
                                  fontSize: 15.0.sp,
                                  color: const Color(0xFF656565),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  selectedProductType == null
                                      ? '--.--'
                                      : '${NumberFormat.currency(decimalDigits: 0, symbol: '', locale: LanguageHelper.isEnglish ? 'en_US' : 'ar_EG').format(getTotal(unitPrice: selectedProductType?.unitPrice ?? 0.0, quantity: _quantityController.text))} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${NumberFormat.decimalPercentPattern(locale: LanguageHelper.isEnglish ? 'en_US' : 'ar_EG').format(widget.createOrderModel.data?.vat ?? 0.0)} ${Languages.of(context)!.vat}',
                                style: TextStyle(
                                  fontSize: 15.0.sp,
                                  color: const Color(0xFF656565),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  selectedProductType == null
                                      ? '--.--'
                                      : '${NumberFormat.currency(decimalDigits: 0, symbol: '', locale: LanguageHelper.isEnglish ? 'en_US' : 'ar_EG').format(getTotal(unitPrice: selectedProductType?.unitPrice, quantity: _quantityController.text) * (widget.createOrderModel.data?.vat ?? 0.0))} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Languages.of(context)!.total,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  selectedProductType == null
                                      ? '--.--'
                                      : '${NumberFormat.currency(decimalDigits: 0, symbol: '', locale: LanguageHelper.isEnglish ? 'en_US' : 'ar_EG').format(getTotal(unitPrice: selectedProductType?.unitPrice ?? 0, quantity: _quantityController.text) + getTotal(unitPrice: selectedProductType?.unitPrice ?? 0, quantity: _quantityController.text) * widget.createOrderModel.data!.vat!)} ${Languages.of(context)!.sar}',
                                  style: TextStyle(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 8.h),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              Languages.of(context)?.notePriceBefore ?? '',
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                color: AppColors().primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 16.h)),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors().primaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ))),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                blocHome.add(StoreOrderEvent(data: {
                                  'quantity': _quantityController.text
                                      .replaceAll(',', ''),
                                  'date': DateFormat('yyyy-MM-dd')
                                      .format(dateTime!),
                                  'product_type_id':
                                      selectedProductType!.id!.toString(),
                                  'payment_method_id':
                                      selectedPaymentMethod!.id!.toString(),
                                  'user_location_id':
                                      selectedStation!.id!.toString(),
                                }));
                              }
                            },
                            child: Text(
                              Languages.of(context)!.submit,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }
}
