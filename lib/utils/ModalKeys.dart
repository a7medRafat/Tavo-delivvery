class CommonKeys {
  static String id = 'id';
  static String createdAt = 'createdAt';
  static String updatedAt = 'updatedAt';
  static String categoryId = 'categoryId';
  static String categoryName = 'categoryName';
  static String itemName = 'itemName';
  static String itemPrice = 'itemPrice';
  static String qty = 'qty';
  static String image = 'image';
  static String isDeleted = 'isDeleted';
  static String review = 'review';
  static String rating = 'rating';
  static String reviewTags = 'reviewTags';
  static String restaurantId = 'restaurantId';
}

class UserKeys {
  static String uid = 'uid';
  static String name = 'name';
  static String email = 'email';
  static String photoUrl = 'photoUrl';
  static String number = 'number';
  static String password = 'password';
  static String loginType = 'loginType';
  static String isAdmin = 'isAdmin';
  static String isTester = 'isTester';
  static String listOfAddress = 'listOfAddress';
  static String role = 'role';
  static String favRestaurant = 'favRestaurant';
  static String city = 'city';
  static String oneSignalPlayerId = 'oneSignalPlayerId';
  static String homeAddress = 'homeAddress';
  static String workAddress = 'workAddress';
}

class RestaurantKeys {
  static String restaurantName = 'restaurantName';
  static String photoUrl = 'photoUrl';
  static String openTime = 'openTime';
  static String closeTime = 'closeTime';
  static String restaurantAddress = 'restaurantAddress';
  static String restaurantContact = 'restaurantContact';
  static String isVegRestaurant = 'isVegRestaurant';
  static String isNonVegRestaurant = 'isNonVegRestaurant';
  static String isDealOfTheDay = 'isDealOfTheDay';
  static String voucher = 'voucher';
  static String voucherCount = 'voucherCount';
  static String caseSearch = 'caseSearch';
  static String restaurantDesc = 'restaurantDesc';
  static String catList = 'catList';
  static String restaurantCity = 'restaurantCity';
  static String ingredientsTags = 'ingredientsTags';
  static String deliveryCharge = 'deliveryCharge';
}

class OrderKeys {
  static String listOfOrder = 'listOfOrder';
  static String totalAmount = 'totalAmount';
  static String totalItem = 'totalItem';
  static String userId = 'userId';
  static String orderStatus = 'orderStatus';
  static String orderId = 'orderId';
  static String userLocation = 'userLocation';
  static String userAddress = 'userAddress';
  static String deliveryBoyLocation = 'deliveryBoyLocation';
  static String deliveryBoyId = 'deliveryBoyId';
  static String paymentMethod = 'paymentMethod';
  static String city = 'city';
  static String paymentStatus = 'paymentStatus';
  static String deliveryCharge = 'deliveryCharge';
}

class CategoryKeys {
  static String color = 'color';
}

class DeliveryBoyReviewKeys {
  static String userId = 'userId';
  static String userName = 'userName';
  static String userImage = 'userImage';
  static String deliveryBoyId = 'deliveryBoyId';
}

class MenuKeys {
  static String ingredientsTags = 'ingredientsTags';
  static String inStock = 'inStock';
  static String description = 'description';
  static String restaurantId = 'restaurantId';
}

class RestaurantReviewKeys {
  static String reviewerId = 'reviewerId';
  static String reviewerName = 'reviewerName';
  static String reviewerImage = 'reviewerImage';
  static String reviewerLocation = 'reviewerLocation';
}

class AddressKeys {
  static String address = 'address';
  static String details = 'details';
  static String userLocation = 'userLocation';
}
