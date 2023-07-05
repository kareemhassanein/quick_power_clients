abstract class StationsEvents {}

class GetStationsEvent extends StationsEvents {
  GetStationsEvent();
}

class AddNewStationEvent extends StationsEvents {
  Map<String, String> data;
  AddNewStationEvent(this.data);
}

class UpdateStationEvent extends StationsEvents {
  String id;
  Map<String, String> data;
  UpdateStationEvent({required this.data, required this.id});
}

class InitialEvent extends StationsEvents {}
