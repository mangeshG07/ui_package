import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

/// A professional multi-select dropdown widget with search and custom styling.
class MultiSelectDropdown extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> items;
  final List<String> selectedItems;
  final void Function(List<String>)? onChanged;

  /// Optional customization
  final double borderRadius;
  final double dropdownMaxHeight;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;

  const MultiSelectDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItems,
    this.onChanged,
    this.borderRadius = 8.0,
    this.dropdownMaxHeight = 300,
    this.fillColor,
    this.hintStyle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        DropdownSearch<String>.multiSelection(
          selectedItems: selectedItems,
          items: (filter, infiniteScrollProps) =>
              items.map((item) => item['name'].toString()).toList(),
          onChanged: onChanged,
          popupProps: PopupPropsMultiSelection.menu(
            showSearchBox: true,
            menuProps: MenuProps(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            constraints: BoxConstraints(maxHeight: dropdownMaxHeight),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              fillColor: fillColor ?? Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              contentPadding: contentPadding ?? const EdgeInsets.all(12),
              hintText: label,
              hintStyle:
                  hintStyle ??
                  const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          suffixProps: const DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              color: Colors.grey,
              iconClosed: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              iconOpened: Icon(Icons.keyboard_arrow_up, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}




// MultiSelectDropdown(
// label: "Select Skills",
// items: [
// {"id": 1, "name": "Flutter"},
// {"id": 2, "name": "React"},
// {"id": 3, "name": "Node.js"},
// ],
// selectedItems: ["Flutter"],
// onChanged: (List<String> selected) {
// print("Selected Items: $selected");
// },
// );
