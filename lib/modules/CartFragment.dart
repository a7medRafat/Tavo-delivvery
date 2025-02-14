import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fooddelivery/components/CartItemComponent.dart';
import 'package:fooddelivery/models/MenuModel.dart';
import 'package:fooddelivery/utils/Colors.dart';
import 'package:fooddelivery/utils/Widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'MyOrderScreen.dart';

class CartFragment extends StatefulWidget {
  static String tag = '/CartFragment';

  const CartFragment({super.key});

  @override
  CartFragmentState createState() => CartFragmentState();
}

class CartFragmentState extends State<CartFragment> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
      appBar: appBarWidget(
        appStore.translate('cart'),
        showBack: false,
        elevation: 0,
        textSize: 20,
        color: appStore.isDarkMode ? scaffoldColorDark : Colors.white,
      ),
      body: Stack(
        children: [
          appStore.isLoggedIn
              ? StreamBuilder<List<MenuModel>>(
                  stream: myCartDBService.cartList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}').center();
                    }
                    if (!snapshot.hasData) {
                      return Loader().center();
                    }
                    if (snapshot.data!.isEmpty) {
                      return noDataWidget(
                        errorMessage: appStore.translate('noDataFound'),
                      ).center();
                    }
                    return ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                      itemBuilder: (context, index) => CartItemComponent(
                        cartData: snapshot.data![index],
                        onUpdate: () {
                          setState(() {});
                        },
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                    );
                  },
                )
              : noDataWidget(
                  errorMessage: appStore.translate('noDataFound'),
                ).center(),
          Observer(
            builder: (_) => viewCartWidget(
              context: context,
              totalItemLength: '${appStore.mCartList.length}',
              onTap: () async {
                MyOrderScreen().launch(context);
              },
            ).visible(appStore.mCartList.isNotEmpty && appStore.isLoggedIn),
          ),
        ],
      ),
    );
  }
}
