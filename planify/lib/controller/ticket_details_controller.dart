import 'package:get/get.dart';

class TicketDetailsController extends GetxController {
  RxString selectedTicketType = 'VIP'.obs;
  RxInt seatCount = 1.obs;

  final Map<String, double> ticketPrices = {
    'VIP': 50.0,
    'Economy': 30.0,
  };

  double get totalPrice => seatCount.value * ticketPrices[selectedTicketType.value]!;
}
