import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AppMultiDropdown extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final String hintText;
  final String? Function(List<String>?)? validator;
  final void Function(List<String>) onChanged;

  const AppMultiDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.hintText = "Select",
    this.validator,
  });

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>.multiSelection(
      items: (filter, infiniteScrollProps) => items,
      selectedItems: selectedItems,
      validator: validator,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
          contentPadding: const EdgeInsets.all(12),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      popupProps: PopupPropsMultiSelection.menu(
        showSelectedItems: false,
        menuProps: MenuProps(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(maxHeight: 300),
      ),
      onChanged: onChanged,
    );
  }
}

// AppMultiDropdown(
// items: catController.categories
//     .map((item) => item['name'].toString())
//     .toList(),
// selectedItems: controller.selectedBusiness,
// hintText: "Business Interest",
// validator: (value) {
// if (value == null || value.isEmpty) {
// return "Please select Interest";
// }
// return null;
// },
// onChanged: (selected) {
// controller.selectedBusiness.value = selected;
// },
// ),
