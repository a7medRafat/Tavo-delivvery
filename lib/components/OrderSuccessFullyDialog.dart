import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/modules/DashboardScreen.dart';
import 'package:fooddelivery/modules/layout/view/layout_screen.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Common.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderSuccessFullyDialog extends StatefulWidget {
  static String tag = '/OrderSuccessFullyDialog';

  const OrderSuccessFullyDialog({super.key});

  @override
  OrderSuccessFullyDialogState createState() => OrderSuccessFullyDialogState();
}

class OrderSuccessFullyDialogState extends State<OrderSuccessFullyDialog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        cachedImage(
          orderPlacedImageURL,
          height: 200,
          width: context.width(),
          fit: BoxFit.fill,
        ).cornerRadiusWithClipRRectOnly(topRight: 12, topLeft: 12),
        16.height,
        Text(appStore.translate('order_placed'), style: boldTextStyle(size: 18)),
        16.height,
        Text(
          appStore.translate('placing_order_Thanks'),
          style: primaryTextStyle(),
          textAlign: TextAlign.center,
        ).paddingOnly(left: 8, right: 8),
        30.height,
        AppButton(
          shapeBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          width: context.width(),
          color: colorPrimary,
          child: Text(appStore.translate('continue'), style: boldTextStyle(color: Colors.white)),
          onTap: () {
            AppLayout().launch(context, isNewTask: true);
          },
        ).paddingOnly(left: 8, right: 8, bottom: 30)
      ],
    );
  }
}
