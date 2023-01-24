abstract class StationsEvents {}

class GetStationsEvent extends StationsEvents {
  GetStationsEvent();
}

class AddNewStationEvent extends StationsEvents {
  Map<String, String> data;
  AddNewStationEvent(this.data);
}
class InitialEvent extends StationsEvents {}
