import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_package/ui_package.dart';
import 'debouncer.dart';

class LocationSearchField extends StatefulWidget {
  final TextEditingController controller;
  final LocationSearchCallback onSearch;
  final LocationSelectedCallback onSelected;

  final String label;
  final String hintText;
  final int debounceMilliseconds;

  const LocationSearchField({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onSelected,
    this.label = 'Location',
    this.hintText = 'Search location...',
    this.debounceMilliseconds = 600,
  });

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final RxList<Map<String, dynamic>> _results = <Map<String, dynamic>>[].obs;
  final RxBool _isSearching = false.obs;

  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: widget.debounceMilliseconds);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(),
        _searchField(context),
        Obx(() {
          if (_isSearching.value) return _loading();
          if (_results.isEmpty) return const SizedBox();
          return _resultsList();
        }),
      ],
    );
  }

  Widget _label() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        widget.label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(14),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  widget.controller.clear();
                  _results.clear();
                  _isSearching.value = false;
                  setState(() {});
                },
              )
            : const Icon(Icons.search),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select location' : null,
      onChanged: _onTextChanged,
    );
  }

  void _onTextChanged(String value) {
    if (value.trim().isEmpty) {
      _results.clear();
      _isSearching.value = false;
      return;
    }

    _isSearching.value = true;

    _debouncer.run(() async {
      try {
        final data = await widget.onSearch(value.trim());
        _results.value = data;
      } catch (_) {
        _results.clear();
      } finally {
        _isSearching.value = false;
      }
    });
  }

  Widget _loading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 8),
          Text('Searching locations...'),
        ],
      ),
    );
  }

  Widget _resultsList() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _results.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, index) {
          final item = _results[index];
          return ListTile(
            leading: const Icon(Icons.place_outlined),
            title: Text(item['description'] ?? ''),
            onTap: () {
              widget.onSelected(item);
              _results.clear();
              _isSearching.value = false;
            },
          );
        },
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey, width: 0.4),
    );
  }
}



// LocationSearchField(
// controller: locationController,
// onSearch: (query) async {
// return await googlePlacesSearch(query);
// },
// onSelected: (location) {
// print(location);
// },
// );