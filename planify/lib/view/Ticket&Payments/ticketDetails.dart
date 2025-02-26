import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/view/Ticket&Payments/eventPayment.dart';
import '../../controller/ticket_details_controller.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketDetailsController ticketDetailsController =
        Get.put(TicketDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Ticket",
          style: GoogleFonts.ptSans(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ticket Type",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildTicketTypeButton(ticketDetailsController, 'VIP'),
                SizedBox(width: 10.w),
                _buildTicketTypeButton(ticketDetailsController, 'Economy'),
              ],
            ),
            SizedBox(height: 30.h),
            Text("Seat",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            _buildSeatCounter(ticketDetailsController),
            SizedBox(height: 30.h),
            const Divider(),
            SizedBox(height: 10.h),
            Obx(() => _buildPriceDetails(ticketDetailsController)),
            const Spacer(),
            const Divider(),
            SizedBox(height: 10.h),
            Obx(() => _buildTotalPrice(ticketDetailsController)),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                onPressed: () => Get.to(() => const PaymentScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 100.w),
                ),
                child: Text("CONTINUE",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketTypeButton(
      TicketDetailsController controller, String type) {
    return Expanded(
      child: Obx(() => GestureDetector(
            onTap: () => controller.selectedTicketType.value = type,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.selectedTicketType.value == type
                    ? const Color.fromARGB(255, 93, 58, 153)
                    : Colors.purple[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                type,
                style: GoogleFonts.roboto(
                  color: controller.selectedTicketType.value == type
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildSeatCounter(TicketDetailsController controller) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (controller.seatCount.value > 1) controller.seatCount.value--;
            },
            icon: Icon(Icons.remove_circle_outline,
                color: const Color.fromARGB(255, 93, 58, 153), size: 30.sp),
          ),
          Obx(() => Text(controller.seatCount.value.toString().padLeft(2, '0'),
              style: GoogleFonts.roboto(
                  fontSize: 24.sp, fontWeight: FontWeight.bold))),
          IconButton(
            onPressed: () => controller.seatCount.value++,
            icon: Icon(Icons.add_circle_outline,
                color: const Color.fromARGB(255, 93, 58, 153), size: 30.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails(TicketDetailsController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Ticket Price",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, fontWeight: FontWeight.w500)),
            Text(
                "\$${controller.ticketPrices[controller.selectedTicketType.value]!.toStringAsFixed(2)} USD",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${controller.seatCount.value} x \$${controller.ticketPrices[controller.selectedTicketType.value]!.toStringAsFixed(2)}",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, fontWeight: FontWeight.w500)),
            Text(
                "\$${(controller.seatCount.value * controller.ticketPrices[controller.selectedTicketType.value]!).toStringAsFixed(2)} USD",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 10.h),
        const Divider(),
      ],
    );
  }

  Widget _buildTotalPrice(TicketDetailsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Price",
            style: GoogleFonts.roboto(
                fontSize: 18.sp, fontWeight: FontWeight.bold)),
        Text("\$${controller.totalPrice.toStringAsFixed(2)} USD",
            style: GoogleFonts.roboto(
                fontSize: 18.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
