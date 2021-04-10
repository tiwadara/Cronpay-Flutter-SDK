import 'package:flutter/material.dart';

void displayBottomSheet(BuildContext context, Widget bottomSheetContent, {VoidCallback onDismiss}) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: bottomSheetContent,
        );
      }).then((value) => onDismiss);
}
