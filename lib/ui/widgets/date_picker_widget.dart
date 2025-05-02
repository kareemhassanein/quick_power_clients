import 'dart:async';

import 'package:Quick_Power/localization/LanguageHelper.dart';
import 'package:Quick_Power/models/create_order_model.dart';
import 'package:Quick_Power/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final DateTime? selectedDateTime;
  final DateTime? minDateTime;
  final DateTime maxDateTime;
  final FutureOr<DateTime?> Function(DateTime?  value) onChanged;
  final String? label;
  final bool enabled;
  final labelInside;
  final List<AvailabilityProduct>? availabilityProduct;
  final Function? disabledAction;
  final String? Function(String?)? validation;

  DatePickerWidget({
    Key? key,
    required this.selectedDateTime,
    required this.minDateTime,
    required this.maxDateTime,
    required this.onChanged,
    this.labelInside = false,
    this.availabilityProduct,
    this.label,
    this.enabled = true,
    this.disabledAction, this.validation,
  }) : super(key: key) {
    controller.text = selectedDateTime == null
        ? ''
        : DateFormat('dd MMMM yyyy', LanguageHelper.isEnglish ? 'en' : 'ar')
        .format(selectedDateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null && !labelInside)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
              child: Text(label ?? ''),
            ),
          GestureDetector(
            onTap: () async {
              if (enabled) {
                await showCalendarDialog(
                  context,
                  selectedDateTime,
                  min: minDateTime??DateTime.now(),
                  max: maxDateTime,
                  availabilityProduct: availabilityProduct
                ).then(onChanged);
              } else if (disabledAction != null) {
                disabledAction?.call();
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: controller,
                  validator: validation,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: labelInside && label != null ? label : null,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.h),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
