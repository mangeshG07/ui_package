import 'package:get/get.dart';

/// Mixin to manage pagination in any GetX controller
mixin PaginationMixin<T> on GetxController {
  /// List of items
  final RxList<T> items = <T>[].obs;

  /// Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;

  /// Pagination config
  int currentPage = 1;
  int perPage = 10;
  bool hasMore = true;

  /// Reset pagination
  void resetPagination() {
    currentPage = 1;
    hasMore = true;
    items.clear();
  }

  /// Start loading
  void startLoading({bool showLoading = true}) {
    if (currentPage == 1) {
      isLoading.value = showLoading;
    } else {
      isLoadMore.value = true;
    }
  }

  /// Handle API success
  void handleSuccess(List<T> newItems) {
    if (currentPage == 1) {
      items.assignAll(newItems);
    } else {
      items.addAll(newItems);
    }

    hasMore = newItems.length >= perPage;
    if (hasMore) currentPage++;
  }

  /// Stop loading
  void stopLoading() {
    isLoading.value = false;
    isLoadMore.value = false;
  }
}

// Future<void> getChatList({
//   bool isRefresh = false,
//   bool showLoading = true,
// }) async {
//   if (isRefresh) resetPagination();
//
//   startLoading(showLoading: showLoading);
//
//   final userId = await LocalStorage.getString('user_id') ?? '';
//
//   try {
//     final response = await _apiService.getChatList(
//       userId,
//       searchController.text.trim(),
//     );
//     if (response['common']['status'] == true) {
//       final List list = response['data'] ?? [];
//
//       handleSuccess(list);
//     }
//   } catch (e) {
//     debugPrint("Error: $e");
//   } finally {
//     stopLoading();
//     // if (showLoading) isLoading.value = false;
//   }
// }
