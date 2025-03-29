import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/view/Ticket&Payments/confrimTicket.dart';

class PaymentController extends GetxController {
  RxString selectedPaymentMethod = 'Apple Pay'.obs;
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "Payment",
          style: GoogleFonts.ptSans(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Method",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10.h),
            _buildPaymentMethod(controller, 'Apple Pay', Icons.apple),
            _buildPaymentMethod(controller, 'PayPal', Icons.paypal_outlined),
            _buildPaymentMethod(controller, 'Google Pay', Icons.payments),
            _buildPaymentMethod(controller, 'Credit Card', Icons.credit_card),
            const Spacer(),
            _gradientButton("CHECKOUT", () => Get.to(() => TicketScreen())),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
      PaymentController controller, String title, IconData icon) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectedPaymentMethod.value = title,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
            decoration: BoxDecoration(
              gradient: controller.selectedPaymentMethod.value == title
                  ? const LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Colors.grey, Colors.black12],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 30.sp, color: Colors.white),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
