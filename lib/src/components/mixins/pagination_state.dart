import 'package:get/get.dart';

/// A reusable, reactive pagination state manager for GetX
///
/// Example:
/// ```dart
/// final pagination = PaginationState<String>();
/// pagination.startLoading();
/// pagination.handleSuccess(['Item1', 'Item2']);
/// pagination.stopLoading();
/// ```
class PaginationState<T> {
  /// Reactive loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;

  /// Reactive list of items
  final RxList<T> items = <T>[].obs;

  /// Pagination parameters
  int currentPage = 1;
  int perPage = 10;
  bool hasMore = true;

  /// Reset all pagination data
  void reset() {
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

  /// Handle success from API or other sources
  ///
  /// `isOthers` if true, will append to list ignoring `currentPage`
  void handleSuccess(List<T> newItems, {bool isOthers = false}) {
    if (isOthers) {
      items.addAll(newItems);
    } else {
      if (currentPage == 1) {
        items.assignAll(newItems);
      } else {
        items.addAll(newItems);
      }
    }

    hasMore = newItems.length >= perPage;
    if (hasMore) currentPage++;
  }

  /// Stop all loading indicators
  void stopLoading() {
    isLoading.value = false;
    isLoadMore.value = false;
  }
}



// final historyPagination = PaginationState<dynamic>();
// final diyPagination = PaginationState<dynamic>();
// final subscriptionPagination = PaginationState<dynamic>();
//
// Future<void> getSubscription({
//   bool isRefresh = false,
//   bool showLoading = true,
// }) async {
//   if (isRefresh) {
//     historyPagination.reset();
//     diyPagination.reset();
//     subscriptionPagination.reset();
//   }
//
//   historyPagination.startLoading(showLoading: showLoading);
//   diyPagination.startLoading(showLoading: false);
//   subscriptionPagination.startLoading(showLoading: false);
//
//   final userId = await LocalStorage.getString('user_id') ?? '';
//   try {
//     final response = await _apiService.getSubscription(
//       userId,
//       historyPagination.currentPage.toString(),
//     );
//     if (response['common']['status'] == true) {
//       currentPlan.value = response['data']['plan_info'] ?? [];
//       final history = response['data']['payment_list'] ?? [];
//       final diy = response['data']['diy_plan'] ?? [];
//       final subscribe = response['data']['subscription'] ?? [];
//
//       // 🔥 Handle history pagination
//       historyPagination.handleSuccess(history);
//
//       // 🔥 Handle diy Pagination
//       diyPagination.handleSuccess(diy, isOthers: true);
//
//       // 🔥 Handle subscribe Pagination
//       subscriptionPagination.handleSuccess(subscribe, isOthers: true);
//       // planHistory.value = response['data']['payment_list'] ?? [];
//       // subscriptionList.value = response['data']['subscription'] ?? [];
//       // diyList.value = response['data']['diy_plan'] ?? [];
//     }
//   } catch (e) {
//     // ToastUtils.showErrorToast('Something went wrong');
//     debugPrint("Error: $e");
//   } finally {
//     historyPagination.stopLoading();
//     diyPagination.stopLoading();
//     subscriptionPagination.stopLoading();
//     // if (showLoading) isLoading.value = false;
//   }
// }