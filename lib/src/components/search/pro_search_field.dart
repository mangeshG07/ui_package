import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

class ProSearchField<T> extends StatelessWidget {
  final List<SearchItem<T>> items;
  final ValueChanged<SearchItem<T>> onSelected;
  final String hintText;
  final IconData leadingIcon;
  final ProSearchTheme theme;

  const ProSearchField({
    super.key,
    required this.items,
    required this.onSelected,
    this.hintText = "Search...",
    this.leadingIcon = Icons.search,
    this.theme = const ProSearchTheme(),
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          hintText: hintText,
          backgroundColor: theme.backgroundColor != null
              ? WidgetStateProperty.all(theme.backgroundColor)
              : null,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(theme.borderRadius),
            ),
          ),
          elevation: WidgetStateProperty.all(theme.elevation),
          padding: WidgetStateProperty.all(theme.padding),
          leading: Icon(leadingIcon),
          onTap: () => controller.openView(),
          onChanged: (_) => controller.openView(),
        );
      },
      suggestionsBuilder: (context, controller) {
        final input = controller.value.text.toLowerCase();

        final filtered = items.where(
          (item) => item.label.toLowerCase().contains(input),
        );

        return filtered.map(
          (item) => ListTile(
            leading: const Icon(Icons.public),
            title: Text(item.label),
            onTap: () {
              controller.closeView(item.label);
              onSelected(item);
            },
          ),
        );
      },
    );
  }
}

//
// final countries = [
//   "India",
//   "Australia",
//   "Canada",
//   "Germany",
//   "Japan",
// ];
//
// final items = countries
//     .map((e) => SearchItem<String>(label: e, value: e))
//     .toList();
//
//
// ProSearchField<String>(
// items: items,
// hintText: "Search country...",
// onSelected: (item) {
// debugPrint("Selected: ${item.value}");
// },
// ),
