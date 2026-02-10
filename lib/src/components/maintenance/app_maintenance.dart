import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A professional, reusable maintenance screen widget.
class MaintenanceScreen extends StatelessWidget {
  /// Message to display under the title
  final String message;

  /// Maintenance image asset path
  final String imageAsset;

  /// Title text
  final String title;

  /// Back button text
  final String buttonText;

  /// Back button action (default: exit app)
  final VoidCallback? onBack;

  /// Screen background color
  final Color backgroundColor;

  /// Text and button colors
  final Color titleColor;
  final Color messageColor;
  final Color buttonTextColor;
  final Color buttonBorderColor;

  const MaintenanceScreen({
    super.key,
    required this.message,
    this.imageAsset = 'assets/images/maintenance.png',
    this.title = 'Under Maintenance',
    this.buttonText = 'Back',
    this.onBack,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.messageColor = Colors.black,
    this.buttonTextColor = Colors.blue,
    this.buttonBorderColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageAsset, width: width * 0.6),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.06,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: messageColor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(width * 0.25, 45),
                foregroundColor: buttonTextColor,
                side: BorderSide(color: buttonBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: onBack ?? () => SystemNavigator.pop(),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}




// MaintenanceScreen(
// message: "We are performing scheduled maintenance. Please check back later.",
// imageAsset: "assets/images/maintenance.png",
// title: "Site Under Maintenance",
// buttonText: "Close App",
// onBack: () {
// // Custom action or exit app
// SystemNavigator.pop();
// },
// backgroundColor: Colors.white,
// titleColor: Colors.red,
// messageColor: Colors.black87,
// buttonTextColor: Colors.red,
// buttonBorderColor: Colors.red,
// );
