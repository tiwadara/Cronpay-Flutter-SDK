

class NetworkConstants {
  static const String MERCHANT_BASE_URL = "https://cronpay.herokuapp.com/v1";
  static const String CLIENT_BASE_URL = "https://recurp.herokuapp.com/api/v1";


  static const String AUTH = "$MERCHANT_BASE_URL/auth";
  static const String REQUEST_OTP = "$AUTH/otp";
  static const String LOGIN = "$AUTH/login";
  static const String GOOGLE_LOGIN = "$AUTH/social-login";
  static const String PASSWORD_RESET = "$AUTH/forgot-password";


  static const String USER = "$MERCHANT_BASE_URL/users";
  static const String SIGN_UP = "$USER/signup";
  static const String PROFILE = "$USER/me";
  static const String NEW_PASSWORD = "$PROFILE/password";
  static const String PHOTO = "$PROFILE/photo";
  static const String GOOGLE_SIGN_UP = "$USER/social-signup";
  static const String VERIFY = "$USER/verify";

  static const String BANKS = "$MERCHANT_BASE_URL/banks";

  static const String EVENTS = "$MERCHANT_BASE_URL/schedules";
  static const String UPCOMING_EVENTS = "$EVENTS/upcoming";
  static const String USER_EVENTS = "$EVENTS/me";
  static const String COUNT = "$USER_EVENTS/count";
  static const String USER_EVENT_DATES = "$EVENTS/dates";


  static const String BENEFICIARIES = "$MERCHANT_BASE_URL/beneficiaries";
  static const String USER_BENEFICIARIES = "$MERCHANT_BASE_URL/beneficiaries/me";

  static const String ACCOUNT = "$MERCHANT_BASE_URL/account";
  static const String PAYMENT_METHODS = "$ACCOUNT/payment-methods";
  static const String SAVED_CARDS = "$PAYMENT_METHODS/me";
  static const String VERIFY_ACCOUNT = "$ACCOUNT/enquiry";

  static const String TRANSACTIONS ="$MERCHANT_BASE_URL/transactions";
  static const String USER_TRANSACTIONS ="$TRANSACTIONS/me";

  static const String MANDATES = "$MERCHANT_BASE_URL/mandates";

  static const String PAYMENT = "$CLIENT_BASE_URL/payment";
  static const String INIT_SDK ="$PAYMENT/methods/cmms/sdk-params";


}
