import 'package:fooddelivery/models/MenuModel.dart';
import 'package:fooddelivery/utils/Constants.dart';

import '../main.dart';
import 'BaseService.dart';

class MyCartDBService extends BaseService {
  MyCartDBService() {
    ref = db.collection(USERS).doc(appStore.userId).collection(CART);
  }

  Stream<List<MenuModel>> cartList() {
    return db.collection('cart').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => MenuModel.fromJson(doc.data())).toList());
  }

  Future<List<MenuModel>> getCartList() async {
    return await ref.get().then((x) => x.docs
        .map((y) => MenuModel.fromJson(y.data() as Map<String, dynamic>))
        .toList());
  }
}
