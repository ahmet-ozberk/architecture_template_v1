import 'package:architecture_template_v1/app/widgets/_dialog/base_dialog.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends BaseDialog {
  const SuccessDialog({
    String? title,
    String? description,
    String? nextRoute,
  }) : super(
          title: title,
          description: description,
          nextRoute: nextRoute,
        );

  @override
  Color get backgroundColor => Colors.lightBlue;

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 50,
          ),
          Text(description ?? 'Something went wrong'),
        ],
      ),
    );
  }
}
