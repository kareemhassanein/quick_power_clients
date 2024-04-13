import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Quick_Power/bloc/home/home_event.dart';
import 'package:Quick_Power/models/cancel_order_model.dart';
import 'package:Quick_Power/models/create_order_model.dart';
import 'package:Quick_Power/models/home_model.dart';
import 'package:Quick_Power/models/order_details_model.dart';
import 'package:Quick_Power/models/orders_pagination_model.dart';
import 'package:Quick_Power/models/post_order_model.dart';
import 'package:Quick_Power/models/user_model.dart';
import 'package:Quick_Power/preference.dart';
import 'package:Quick_Power/repository/orders_repo.dart';

import '../../repository/auth_repo.dart';
import '../../repository/internet_conncection.dart';
import '../general_states.dart';

class HomeBloc extends Bloc<HomeEvents, GeneralStates> {
  HomeBloc() : super(InitialState());
  @override
  Stream<GeneralStates> mapEventToState(
    HomeEvents event,
  ) async* {
    if (event is GetHomeAllEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState(showDialog: event.refresh);
        HomeModel? responseModel = await OrdersRepo().getHomeAll();
        if (responseModel != null) {
          if (responseModel.success != null && !responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.data != null &&
              responseModel.success != null &&
              responseModel.success!) {
            yield SuccessState(
                msg: responseModel.message,
                response: responseModel,
                showDialog: false);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is GetOrdersPaginationEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState(showDialog: false);
        OrdersPaginationModel? responseModel = await OrdersRepo()
            .getOrdersPagination(type: event.type, page: event.page);
        if (responseModel != null) {
          responseModel.type = event.type;
          if (!responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.data != null && responseModel.success!) {
            yield SuccessState(
                msg: responseModel.message,
                response: responseModel,
                showDialog: false);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is GetCreateOrderEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState();
        CreateOrderModel? responseModel = await OrdersRepo().getCreateOrder();
        if (responseModel != null) {
          if (!responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.data != null && responseModel.success!) {
            yield SuccessState(
                msg: responseModel.message,
                response: responseModel,
                showDialog: false);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is StoreOrderEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState();
        PostOrderModel? responseModel =
            await OrdersRepo().storeOrder(data: event.data);
        if (responseModel != null) {
          if (responseModel.success != null && !responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.success != null && responseModel.success!) {
            yield SuccessState(msg: responseModel.message, showDialog: true);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is GetOrderDetailsEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState();
        OrderDetailsModel? responseModel =
            await OrdersRepo().getOrderDetails(id: event.id);
        if (responseModel != null) {
          if (responseModel.success != null && !responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.success != null && responseModel.success!) {
            yield SuccessState(msg: responseModel.message, showDialog: false, response: responseModel);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is CancelOrderEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState();
        CancelOrderModel? responseModel =
            await OrdersRepo().cancelOrder(id: event.id);
        if (responseModel != null) {
          if (responseModel.success != null && !responseModel.success!) {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          } else if (responseModel.success != null && responseModel.success!) {
            yield SuccessState(msg: responseModel.message, showDialog: true);
          } else {
            yield ErrorState(
              msg: responseModel.message ?? 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    } else if (event is InitialEvent) {
      yield InitialState();
    }
  }

  GeneralStates get initialState => InitialState();
}
