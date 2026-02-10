import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewDialog extends StatefulWidget {
  final String productName;
  final String imageUrl;

  /// Called when user taps submit
  final void Function(double rating, String review) onSubmit;

  /// Optional theme customization
  final Color primaryColor;
  final Color textColor;

  const ReviewDialog({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.onSubmit,
    this.primaryColor = Colors.blue,
    this.textColor = Colors.black,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 0;
  bool _isSubmitting = false;
  final TextEditingController _reviewController = TextEditingController();

  void _submit() {
    if (_rating == 0) {
      _showRatingRequiredDialog();
      return;
    }

    setState(() => _isSubmitting = true);

    widget.onSubmit(_rating, _reviewController.text.trim());

    Navigator.of(context).pop();
  }

  void _showRatingRequiredDialog() {
    final message = 'Please select a rating before submitting.';

    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Rating Required'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Rating Required'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _productHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.productName,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ratingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('How would you rate this product?'),
        const SizedBox(height: 8),
        Center(
          child: RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            itemCount: 5,
            itemSize: 32,
            unratedColor: Colors.grey.shade300,
            itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (value) {
              setState(() => _rating = value);
            },
          ),
        ),
      ],
    );
  }

  Widget _reviewInput() {
    return TextField(
      controller: _reviewController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Tell us about your experience...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    if (isIOS) {
      return CupertinoAlertDialog(
        title: const Text('Write a Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            _productHeader(),
            const SizedBox(height: 16),
            _ratingSection(),
            const SizedBox(height: 16),
            _reviewInput(),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const CupertinoActivityIndicator()
                : const Text('Submit'),
          ),
        ],
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _productHeader(),
            const SizedBox(height: 20),
            _ratingSection(),
            const SizedBox(height: 20),
            _reviewInput(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.primaryColor,
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// showDialog(
// context: context,
// builder: (_) => ReviewDialog(
// productName: 'iPhone 15',
// imageUrl: 'https://example.com/image.png',
// onSubmit: (rating, review) {
// print(rating);
// print(review);
// },
// ),
// );
