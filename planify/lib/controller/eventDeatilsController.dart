import 'package:get/get.dart';
import '../model/eventCardModel.dart';

class EventDetailsController extends GetxController {
  var event = NewEventData(
    eventName: '',
    location: '',
    date: '',
    imageUrl: '',
    organizer: '',
    description: '',
    price: '',
    members: 0,
  ).obs;

  var isFavorite = false.obs;
  var currentIndex = 0.obs;

  /// Set new event details
  void setEventDetails(NewEventData newEvent) {
    event.update((val) {
      if (val != null) {
        val.eventName = newEvent.eventName;
        val.location = newEvent.location;
        val.date = newEvent.date;
        val.imageUrl = newEvent.imageUrl;
        val.organizer = newEvent.organizer;
        val.description = newEvent.description;
        val.members = newEvent.members;
      }
    });
  }

  /// Toggle favorite event
  void toggleFavorite() {
    isFavorite.toggle();
  }

  /// Update carousel index
  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
