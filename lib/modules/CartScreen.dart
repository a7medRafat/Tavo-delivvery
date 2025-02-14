import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fooddelivery/components/CartItemComponent.dart';
import 'package:fooddelivery/config/colors/app_colors.dart';
import 'package:fooddelivery/core/shared_widgets/app_bar.dart';
import 'package:fooddelivery/models/MenuModel.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'MyOrderScreen.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  static String tag = '/CartScreen';
  bool isRemove = false;
  int? deliveryCharge = 0;

  CartScreen({super.key, required this.isRemove, this.deliveryCharge});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
    );
    setValue(DELIVERY_CHARGES, widget.deliveryCharge);
  }

  @override
  void dispose() {
    setStatusBarColor(
      appStore.isDarkMode ? scaffoldColorDark : colorPrimary,
      statusBarIconBrightness:
          appStore.isDarkMode ? Brightness.light : Brightness.dark,
    );
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: MyAppBar(
        title: Text(
          appStore.translate('cart'),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<MenuModel>>(
            stream: myCartDBService.cartList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString()).center();
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return noDataWidget(
                          errorMessage: appStore.translate('noDataFound'))
                      .center();
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    itemBuilder: (context1, index) => CartItemComponent(
                      cartData: snapshot.data![index],
                      onUpdate: () {
                        if (widget.isRemove) {
                          finish(context);
                        }
                        setState(() {});
                      },
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                  );
                }
              }
              return Loader().center();
            },
          ),
          Observer(
            builder: (_) => viewCartWidget(
              context: context,
              totalItemLength: '${appStore.mCartList.length}',
              onTap: () {
                MyOrderScreen().launch(context);
              },
            ).visible(appStore.mCartList.isNotEmpty && appStore.isLoggedIn),
          )
        ],
      ),
    );
  }
}
