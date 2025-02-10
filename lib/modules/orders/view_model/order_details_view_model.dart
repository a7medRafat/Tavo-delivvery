import 'package:flutter/material.dart';
import 'package:fooddelivery/main.dart';
import 'package:fooddelivery/models/OrderModel.dart';
import 'package:fooddelivery/services/DeliveryBoyReviewDBService.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderDetailsViewModel extends ChangeNotifier {
  late DeliveryBoyReviewsDBService deliveryBoyReviewsDBService;
  bool isReview = false;
  String orderStatus = '';

  Future init(OrderModel orderData) async {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : Colors.white,
      statusBarIconBrightness: Brightness.light,
    );
    review(orderData);

    myOrderDBService.orderById(id: orderData.id).listen((event) async {
      orderData = event;
      notifyListeners();
    });
  }

  review(OrderModel orderData) async {
    deliveryBoyReviewsDBService =
        DeliveryBoyReviewsDBService(restId: orderData.id);

    deliveryBoyReviewsDBService
        .deliveryBoyReviews(orderID: orderData.id)
        .listen((event) async {
      isReview = event;
      notifyListeners();
    });
  }

  void cancelOrder(OrderModel orderData) async {
    Map<String, dynamic> data = {
      OrderKeys.orderStatus: ORDER_CANCELLED,
      CommonKeys.updatedAt: DateTime.now(),
    };

    myOrderDBService.updateDocument(data, orderData.id).then((res) async {
      toast(appStore.translate('order_cancelled'));

      orderData.orderStatus = ORDER_CANCELLED;

      notifyListeners();
    }).catchError((error) {
      toast(error.toString());
      notifyListeners();
    });
  }
}
