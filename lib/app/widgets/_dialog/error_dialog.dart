import 'package:architecture_template_v1/app/widgets/_dialog/base_dialog.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends BaseDialog {
  const ErrorDialog({
    String? title,
    String? description,
    String? nextRoute,
  }) : super(
          title: title,
          description: description,
          nextRoute: nextRoute,
        );

  @override
  void show() {
    super.show();
  }

  @override
  Color get backgroundColor => Colors.red;

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.white,
            size: 50,
          ),
          Text(description ?? 'Something went wrong'),
        ],
      ),
    );
  }
}
