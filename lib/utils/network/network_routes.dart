// import '../../features/auth/cubit/auth/auth_cubit.dart';
//
import '../../state-managment/bloc/auth/auth_cubit.dart';

dynamic headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};
dynamic headersWithToken = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${AuthCubit.user?.token}',
};
const baseUrl = 'http://72.62.237.230/api';
const userAuthBaseUrl = '$baseUrl/auth';
const imagePathUrl = "http://72.62.237.230/images/";
const categoriesImagePathUrl = "http://72.62.237.230/images/categories/";
const productsImagePathUrl = "http://72.62.237.230/images/products/";
const bannersImagePathUrl = "http://72.62.237.230/images/banners/";

const logoutApi = '$userAuthBaseUrl/logout?';
const loginApi = '$userAuthBaseUrl/login?';
const registerApi = '$userAuthBaseUrl/register?';
const refreshTokenApi = '$userAuthBaseUrl/refresh?';
const deleteAccountApi = '$userAuthBaseUrl/deleteAccount?';
//
// const imageApi = '$storeBaseUrl/products/image';
// const videoApi = '$baseUrl/video';
// const voiceApi = '$baseUrl/voice';
//
// const ordersApi = '$storeBaseUrl/orders';
// const orderApi = '$storeBaseUrl/order';
// const storeCanceledApi = '$orderApi/canceled';
// const storeReceivedToDriverApi = '$orderApi/received';
// const storeRejectApi = '$orderApi/reject';
// const storeAcceptApi = '$orderApi/accept';
// const getOrderDetailsApi = '$orderApi/details';
// const getCurrentStoreOrderDetailsApi = '$orderApi/current';
//
// const notificationApi = '$baseUrl/notification';
// const getFireMessagingAccessTokenApi = '$notificationApi/fire-messaging-token';
// const sendNotificationApi = '$notificationApi/send';
