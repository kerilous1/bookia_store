class ApiConstants {

  //auth Endpoints
  static const String baseurl='https://codingarabic.online/api';
  static const String login='$baseurl/login';
  static const String register='$baseurl/register';
  static const String verifyEmail='$baseurl/verify-email';
  static const String resendVerifyCode = '$baseurl/resend-verify-code';

  //Home & Products Endpoints
  static const String sliders='$baseurl/sliders';
  static const String categories='$baseurl/categories';
  static const String products='$baseurl/products';
  static const String newArrivals='$baseurl/products-new-arrivals';
  static const String bestSellers='$baseurl/products-bestseller';

  static const String searchProducts = '$baseurl/products-search';

  static const String showWishlist = '$baseurl/wishlist';
  static const String addWishlist = '$baseurl/add-to-wishlist';
  static const String removeWishlist = '$baseurl/remove-from-wishlist';
}