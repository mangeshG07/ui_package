import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_package/src/core/theme/app_colors.dart';
import 'package:ui_package/ui_package.dart';

/// A reusable dropdown search component for Flutter applications.
/// Supports preselected values, search functionality, validation, and custom height.
class DropdownSearchComponent<T> extends StatelessWidget {
  final T? preselectedValue;
  final String hintText;
  final String searchHintText;
  final bool showSearchBox;
  final double dropdownHeight;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final String Function(T)? itemAsString;

  const DropdownSearchComponent({
    super.key,
    this.preselectedValue,
    this.showSearchBox = true,
    required this.hintText,
    required this.searchHintText,
    required this.items,
    required this.onChanged,
    required this.dropdownHeight,
    this.validator,
    this.itemAsString,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      selectedItem: preselectedValue,
      compareFn: (item1, item2) => item1 == item2,
      validator: validator,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.border,
            fontWeight: FontWeight.normal,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          border: _borderStyle(),
          enabledBorder: _borderStyle(),
          focusedBorder: _borderStyle(),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),

      items: (filter, infiniteScrollProps) => items,
      itemAsString: itemAsString ?? (item) => item.toString(),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        constraints: BoxConstraints.tightFor(height: dropdownHeight),
        showSearchBox: showSearchBox,
        menuProps: const MenuProps(backgroundColor: Colors.white),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: _borderStyle(),
            hintText: searchHintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }

  OutlineInputBorder _borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.border),
    );
  }
}
