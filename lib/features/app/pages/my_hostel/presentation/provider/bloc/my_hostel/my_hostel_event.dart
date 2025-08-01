abstract class MyHostelsEvent {}

class FetchMyHostels extends MyHostelsEvent {
  final String ownerId;
  FetchMyHostels(this.ownerId);
}