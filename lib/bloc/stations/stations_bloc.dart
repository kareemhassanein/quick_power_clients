import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqoodi_client/bloc/stations/stations_event.dart';
import 'package:waqoodi_client/repository/statios_repo.dart';

import '../../models/stations_model.dart';
import '../../repository/internet_conncection.dart';
import '../general_states.dart';

class StationsBloc extends Bloc<StationsEvents, GeneralStates> {
  StationsBloc() : super(InitialState());
  @override
  Stream<GeneralStates> mapEventToState(
    StationsEvents event,
  ) async* {
    if (event is GetStationsEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState();
        print('sssss');
        StationsModel? stationsModel = await StationsRepo().allStations();
        print('sssss');
        if (stationsModel != null) {
          if (stationsModel.message != null) {
            yield ErrorState(
              msg: stationsModel.message ?? 'Something Went Wrong!',
            );
          } else if (stationsModel.data != null && stationsModel.success!) {
            yield SuccessState(response: stationsModel.data, showDialog: false);
          } else {
            yield ErrorState(
              msg: stationsModel.message ?? 'Something Went Wrong!',
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
    } else if (event is AddNewStationEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState(showDialog: true);
        dynamic response = await StationsRepo().storeStation(event.data);
        if (response['errors'] == null) {
          yield SuccessState(showDialog: true, msg: 'Station Added');
          StationsModel? stationsModel = await StationsRepo().allStations();
          if (stationsModel != null) {
            if (stationsModel.message != null) {
              yield ErrorState(
                msg: stationsModel.message ?? 'Something Went Wrong!',
              );
            } else if (stationsModel.data != null && stationsModel.success!) {
              yield SuccessState(response: stationsModel.data, showDialog: false);
            } else {
              yield ErrorState(
                msg: stationsModel.message ?? 'Something Went Wrong!',
              );
            }
          } else {
            yield ErrorState(
              msg: 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: response['message'] ?? 'Something Went Wrong!',
          );
        }
      } else {
        yield NoInternetState();
      }
    }else if (event is UpdateStationEvent) {
      if (await InternetConnection().isConnected()) {
        yield LoadingState(showDialog: true);
        dynamic response = await StationsRepo().updateStation(id: event.id, data: event.data);
        print(response.toString());
        if (response['errors'] == null) {
          yield SuccessState(showDialog: true, msg: 'Station Updated');
          StationsModel? stationsModel = await StationsRepo().allStations();
          if (stationsModel != null) {
            if (stationsModel.message != null) {
              yield ErrorState(
                msg: stationsModel.message ?? 'Something Went Wrong!',
              );
            } else if (stationsModel.data != null && stationsModel.success!) {
              yield SuccessState(response: stationsModel.data, showDialog: false);
            } else {
              yield ErrorState(
                msg: stationsModel.message ?? 'Something Went Wrong!',
              );
            }
          } else {
            yield ErrorState(
              msg: 'Something Went Wrong!',
            );
          }
        } else {
          yield ErrorState(
            msg: response['message'] ?? 'Something Went Wrong!',
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
