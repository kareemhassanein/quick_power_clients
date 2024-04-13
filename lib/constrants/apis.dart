class Apis {
  static const serverUrl = 'https://quickpower.hillksa.com/api/application';
  static const login = '$serverUrl/auth/login';
  static const signUp = '$serverUrl/auth/register';
  static const getStations = '$serverUrl/locations';
  static const storeStation = '$serverUrl/locations/store';
  static const showProfile = '$serverUrl/profile/show';
  static const changeUserImage = '$serverUrl/profile/change-photo';
  static const changeUserData = '$serverUrl/profile/update';
  static const changePassword = '$serverUrl/profile/changePassword';
  static const createOrder = '$serverUrl/waybills/create';
  static const storeOrder = '$serverUrl/waybills/store';
  static const homeAll = '$serverUrl/waybills/all';
  static homePagination({required type, required page}) => '$serverUrl/waybills?waybill_status=$type&page=$page';
  static orderDetails({required id}) => '$serverUrl/waybills/$id';
  static cancelOrder({required id}) => '$serverUrl/waybills/$id/cancel';
  static updateStation({required id}) => '$serverUrl/locations/$id/update';
  static const sendOtpforgetPassword = '$serverUrl/auth/send-otp';
  static const resetPassword = '$serverUrl/auth/reset-password';
}
