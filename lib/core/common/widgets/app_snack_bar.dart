import 'package:flutter/material.dart';

import '../../../app/localization/resources.dart';

mixin AppSnackBar {
  static void notificationSnackBar(BuildContext context,
      {String message = ""}) {
    ScaffoldMessenger.of(context).showSnackBar(_snackBarWidget(
      context,
      message: message,
    ));
  }

  static SnackBar _snackBarWidget(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return SnackBar(
      content: Text(
        Resources.of(context).getResource(message),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
  }
}
