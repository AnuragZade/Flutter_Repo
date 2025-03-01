class NewEventData {
  String eventName;
  String location;
  String date;
  String imageUrl;
  String organizer;
  String description;
  String price;
  int members;

  NewEventData({
    required this.eventName,
    required this.location,
    required this.date,
    required this.imageUrl,
    required this.organizer,
    required this.description,
    required this.price,
    required this.members,
  });

  // ✅ Add this method to parse data from Firestore or API response
  factory NewEventData.fromMap(Map<String, dynamic> map) {
    return NewEventData(
      eventName: map["eventName"] ?? map["title"] ?? "",
      date: map["eventDate"] ?? map["date"] ?? "",
      location: map["eventLocation"] ?? map["location"] ?? "",
      price: map["eventTicketPrice"] ?? map["price"] ?? "",
      organizer: map["eventOrganizerName"] ?? map["organizer"] ?? "",
      description: map["eventDescription"] ?? map["description"] ?? "",
      imageUrl: (map["images"] != null && map["images"].isNotEmpty)
          ? map["images"][0]
          : "https://via.placeholder.com/150",
      members: int.tryParse(map["members"]?.toString() ?? "0") ?? 0,
    );
  }
}
