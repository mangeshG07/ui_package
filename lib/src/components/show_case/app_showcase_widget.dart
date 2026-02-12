import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:ui_package/src/core/theme/app_colors.dart';
import 'package:ui_package/src/utils/dimens.dart';
import 'package:ui_package/src/utils/size_context.dart';

class AppShowCaseWidget extends StatelessWidget {
  const AppShowCaseWidget({
    super.key,
    required this.globalKey,
    required this.title,
    required this.description,
    required this.progressValue,
    required this.child,
    required this.index,
    required this.totalSteps,
  });

  final GlobalKey globalKey;
  final String title;
  final String description;
  final double progressValue;
  final Widget child;
  final int index;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      key: globalKey,
      targetShapeBorder: const CircleBorder(),
      disableBarrierInteraction: true,
      targetPadding: EdgeInsets.all(30),
      overlayOpacity: 0.4,
      targetBorderRadius: BorderRadius.circular(50),
      container: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.widthPx,
            padding: const EdgeInsets.all(Dimens.largePadding),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimens.corners),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Dimens.padding,
              children: [
                /// 🔥 Top Row (Title + Close Button)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ShowcaseView.get().dismiss(),
                      child: const Icon(Icons.close, size: 22),
                    ),
                  ],
                ),
                Text(description),
                SizedBox(height: Dimens.largePadding),
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(Dimens.corners),
                  value: progressValue,
                  minHeight: 7,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                ),
                SizedBox.shrink(),

                /// 🔥 Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Previous
                    if (index != 0)
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
                        ),
                        onPressed: () => ShowcaseView.get().previous(),
                        child: const Text("Previous"),
                      )
                    else
                      const SizedBox(width: 90),

                    /// Next / Finish
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () {
                        if (index == totalSteps - 1) {
                          ShowcaseView.get().dismiss();
                        } else {
                          ShowcaseView.get().next();
                        }
                      },
                      child: Text(index == totalSteps - 1 ? "Finish" : "Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}



// final GlobalKey exploreKey = GlobalKey();
// final GlobalKey feedsKey = GlobalKey();
// final GlobalKey myBusinessKey = GlobalKey();
// late List<Map<String, dynamic>> tabs;
//
// @override
// void initState() {
//   super.initState();
//
//   tabs = [
//     {
//       'icon': HugeIcons.strokeRoundedBriefcase08,
//       'label': 'Explorer',
//       'intro': 'Explore businesses & services here',
//       'featureId': 'feature_explorer',
//       'key': exploreKey,
//     },
//     {
//       'icon': HugeIcons.strokeRoundedMenuSquare,
//       'label': 'Feeds',
//       'intro': 'Check latest feeds & updates',
//       'featureId': 'feature_feeds',
//       'key': feedsKey,
//     },
//     {
//       'icon': HugeIcons.strokeRoundedUser03,
//       'label': 'My Business',
//       'intro': 'Manage your business profile here',
//       'featureId': 'feature_my_business',
//       'key': myBusinessKey,
//     },
//   ];
//
//   ShowcaseView.register(
//     autoPlayDelay: const Duration(seconds: 3),
//
//     // globalFloatingActionWidget: (showcaseContext) {
//     //   return FloatingActionWidget(
//     //     top: 100,
//     //     right: 20,
//     //     child: ElevatedButton(
//     //       style: ElevatedButton.styleFrom(
//     //         backgroundColor: Colors.red,
//     //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     //       ),
//     //       onPressed: () => ShowcaseView.get().dismiss(),
//     //       child: const Text("Skip", style: TextStyle(color: Colors.white)),
//     //     ),
//     //   );
//     // },
//     // globalFloatingActionWidget: (showcaseContext) => FloatingActionWidget(
//     //   left: 16,
//     //   bottom: 16,
//     //   child: Padding(
//     //     padding: const EdgeInsets.all(Dimens.largePadding),
//     //     child: ElevatedButton(
//     //       onPressed: () => ShowcaseView.get().dismiss(),
//     //       style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//     //       child: Row(
//     //         spacing: Dimens.padding,
//     //         children: [
//     //           Icon(Icons.close, color: Colors.white),
//     //           const Text('Close', style: TextStyle(color: Colors.white)),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // ),
//     // globalTooltipActions: [
//     //   // TooltipActionButton(
//     //   //   type: TooltipDefaultActionType.previous,
//     //   //   textStyle: const TextStyle(color: Colors.white),
//     //   //   backgroundColor: Colors.deepOrange,
//     //   //   hideActionWidgetForShowcase: [exploreKey],
//     //   // ),
//     //   TooltipActionButton(
//     //     type: TooltipDefaultActionType.previous,
//     //     textStyle: const TextStyle(color: Colors.white),
//     //     backgroundColor: Colors.deepOrange,
//     //     hideActionWidgetForShowcase: [feedsKey],
//     //   ),
//     //   TooltipActionButton(
//     //     type: TooltipDefaultActionType.next,
//     //     textStyle: const TextStyle(color: Colors.white),
//     //     backgroundColor: Colors.deepOrange,
//     //     hideActionWidgetForShowcase: [myBusinessKey],
//     //   ),
//     // ],
//     onStart: (index, key) {},
//     onComplete: (index, key) {},
//     onDismiss: (key) {},
//     onFinish: () {},
//   );
//
//   WidgetsBinding.instance.addPostFrameCallback(
//         (_) => ShowcaseView.get().startShowCase([
//       exploreKey,
//       feedsKey,
//       myBusinessKey,
//     ]),
//   );
// }
//
// @override
// void dispose() {
//   ShowcaseView.get().unregister();
//   super.dispose();
// }