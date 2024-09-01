import 'package:Quick_Power/constrants/colors.dart';
import 'package:Quick_Power/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../localization/Language/Languages.dart';

class DropdownCus extends StatelessWidget {
  final String? title;
  final List<dynamic> items;
  final dynamic selected;
  final void Function(dynamic) onChanged;
  final bool enabled;
  final bool withSearch;
  final String? hintSearch;
  final String? Function(dynamic)? validation;
  final Widget Function(BuildContext, dynamic, bool)? itemBuilder;


  const DropdownCus({
    Key? key,
    this.enabled = true,
    required this.onChanged,
    required this.selected,
    this.hintSearch,
    required this.items,
    this.withSearch = false,
    this.itemBuilder,
    required this.title, this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
              child: Text(title!),
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: DropdownSearch<dynamic>(
              selectedItem: selected,
              onChanged: onChanged,
              validator: validation,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              popupProps: PopupProps<dynamic>.dialog(
                itemBuilder: itemBuilder??(c, e, b) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 275.w,
                        child: Text(
                          e?.name ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Visibility(
                        visible: e == selected,
                        child: const Icon(Icons.check_rounded),
                      ),
                    ],
                  ),
                ),
                showSearchBox: withSearch,
                dialogProps: DialogProps(
                  elevation: 0,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  barrierLabel: '',
                  barrierColor: Colors.black12,
                  transitionDuration: Duration.zero,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  transitionBuilder: customTransitionDuration(
                    edgeInsets:
                        EdgeInsets.symmetric(vertical: 160.h, horizontal: 24.w),
                  ),
                ),
                listViewProps: const ListViewProps(padding: EdgeInsets.zero),
                emptyBuilder: (c, s) =>
                    Center(child: Text(Languages.of(context)?.noOrders ?? '')),
                searchFieldProps: TextFieldProps(
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  enabled: enabled,
                  cursorColor: AppColors().primaryColor,
                  decoration: InputDecoration(
                    hintText: hintSearch,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                      borderSide: BorderSide(color: Colors.grey, width: 1.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                      borderSide: BorderSide(
                          color: AppColors().primaryColor, width: 1.r),
                    ),
                  ),
                ),
                isFilterOnline: true,
                searchDelay: Duration.zero,
              ),
              dropdownButtonProps: const DropdownButtonProps(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_drop_down_rounded)),
              items: items,

              dropdownDecoratorProps:  DropDownDecoratorProps(
                textAlign: TextAlign.start,

                dropdownSearchDecoration:
                InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.h),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,

              ),
              enabled: enabled,
              dropdownBuilder: (c, e) => Text(
                e?.name ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              filterFn: (user, filter) => user.name!.toString().toLowerCase().contains(filter.toLowerCase()),
            ),
          ),
        ],
      ),
    );
  }
}
