abstract class CheckoutValidator {
  static isSuccess(String url){
    return url.trim().toLowerCase().contains('status=success');
  }

  static isFailed(String url){
    return url.trim().toLowerCase().contains('status=fail');
  }
}