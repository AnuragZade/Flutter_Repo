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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        title: Text(
          "Payment",
          style: GoogleFonts.ptSans(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.add_card, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Method",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            _buildPaymentMethod(controller, 'Apple Pay', Icons.apple),
            _buildPaymentMethod(controller, 'PayPal', Icons.paypal_outlined),
            _buildPaymentMethod(controller, 'Google Pay', Icons.payments),
            _buildPaymentMethod(controller, 'Credit Card', Icons.credit_card),
            SizedBox(height: 30.h),
            Text("Add Voucher",
                style: GoogleFonts.roboto(
                    fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "VOUCHER CODE",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 10.w),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  ),
                  child: Text("APPLY",
                      style: GoogleFonts.roboto(color: Colors.white)),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => Get.to(() => TicketScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                padding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 100.w),
              ),
              child: Text("CHECKOUT",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
      PaymentController controller, String title, IconData icon) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectedPaymentMethod.value = title,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: controller.selectedPaymentMethod.value == title
                  ? const Color.fromARGB(255, 93, 58, 153)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon,
                    size: 30.sp,
                    color: controller.selectedPaymentMethod.value == title
                        ? Colors.white
                        : Colors.black),
                SizedBox(width: 10.w),
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: controller.selectedPaymentMethod.value == title
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
