import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddelivery/models/RestaurantModel.dart';
import 'package:fooddelivery/services/BaseService.dart';
import 'package:fooddelivery/utils/Constants.dart';
import 'package:fooddelivery/utils/ModalKeys.dart';

import '../main.dart';

class RestaurantDBService extends BaseService {
  RestaurantDBService() {
    ref = db.collection(RESTAURANTS);
  }

  Stream<List<RestaurantModel>> restaurants({required String searchText}) {
    return restaurantsQuery(searchText: searchText).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                RestaurantModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Query restaurantsQuery({String searchText = ''}) {
    Query query = ref.where(CommonKeys.isDeleted, isEqualTo: false);

    if (searchText.isNotEmpty) {
      query = query.where(RestaurantKeys.caseSearch,
          arrayContains: searchText.toLowerCase());
    }

    return query;
  }

  Stream<List<RestaurantModel>> restaurantByCategory(String? categoryName,
      {String? searchText}) {
    Query query = ref
        .where(RestaurantKeys.catList, arrayContains: categoryName)
        .where(CommonKeys.isDeleted, isEqualTo: false);

    if (searchText != null && searchText.isNotEmpty) {
      query = query.where(RestaurantKeys.caseSearch,
          arrayContains: searchText.toLowerCase());
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            RestaurantModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<List<RestaurantModel>> getFavRestaurantList() async {
    if (favRestaurantList.isNotEmpty) {
      Query query = ref
          .where(CommonKeys.id, whereIn: favRestaurantList)
          .where(CommonKeys.isDeleted, isEqualTo: false)
          .orderBy(CommonKeys.updatedAt, descending: true);

      return await query.get().then((x) {
        return x.docs
            .map((y) =>
                RestaurantModel.fromJson(y.data() as Map<String, dynamic>))
            .toList();
      });
    } else {
      return [];
    }
  }

  Future<RestaurantModel> getRestaurantById({String? restaurantId}) async {
    return await ref
        .where(CommonKeys.id, isEqualTo: restaurantId)
        .get()
        .then((res) {
      if (res.docs.isEmpty) {
        throw appStore.translate('noRestaurantFound');
      } else {
        return RestaurantModel.fromJson(
            res.docs.first.data() as Map<String, dynamic>);
      }
    }).catchError((error) {
      throw error.toString();
    });
  }

  Future<void> updateRestaurantDate(
      {required String restaurantId, required String voucherCount}) async {
    try {
      final docRef = ref.doc(restaurantId);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'voucherCount': voucherCount,
        });
      }
    } catch (e) {
      print("Error updating restaurant date: $e");
    }
  }
}
