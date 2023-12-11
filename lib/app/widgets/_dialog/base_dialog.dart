import 'package:architecture_template_v1/app/utility/constant/app_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

abstract class BaseDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? nextRoute;

  const BaseDialog({
    this.title,
    this.description,
    this.nextRoute,
  });

  /// Shows an adaptive dialog above the current contents of the app, with
  /// material or Cupertino stylings, depending on the platform.
  void show() {
    showAdaptiveDialog(
      context: AppConstant.context,
      barrierDismissible: false,
      builder: (context) => this,
    );
  }

  /// Override this method to change the background color of the dialog.
  Color get backgroundColor => Colors.white;

  @protected
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: backgroundColor,
      title: title != null ? Text(title!) : null,
      content: buildContent(context),
      actions: [
        GrockAdaptiveDialogButton(
          child: Text('Tamam'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
            if (nextRoute != null) {
              Navigator.of(context).pushNamed(nextRoute!);
            }
          },
        ),
      ],
    );
  }
}
