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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Ticket Details",
          style: GoogleFonts.ptSans(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _glassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ticket Type",
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              _buildTicketTypeButton(
                                  ticketDetailsController, 'VIP'),
                              SizedBox(width: 10.w),
                              _buildTicketTypeButton(
                                  ticketDetailsController, 'Economy'),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text("Seat Selection",
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(height: 10.h),
                          _buildSeatCounter(ticketDetailsController),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    _buildTotalPrice(ticketDetailsController),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: _gradientButton(
                "CONTINUE", () => Get.to(() => const PaymentScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketTypeButton(
      TicketDetailsController controller, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTicketType.value = type,
        child: _glassContainer(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: controller.selectedTicketType.value == type
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildSeatCounter(TicketDetailsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            if (controller.seatCount.value > 1) controller.seatCount.value--;
          },
          icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
        ),
        Obx(() => AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                controller.seatCount.value.toString().padLeft(2, '0'),
                key: ValueKey<int>(controller.seatCount.value),
                style: GoogleFonts.roboto(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
        IconButton(
          onPressed: () => controller.seatCount.value++,
          icon: const Icon(Icons.add_circle_outline, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTotalPrice(TicketDetailsController controller) {
    return Obx(() => AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price",
                  style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(
                "\$${controller.totalPrice.toStringAsFixed(2)} USD",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
            ],
          ),
        ));
  }

  Widget _gradientButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _glassContainer({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2),
        ],
      ),
      child: child,
    );
  }
}
