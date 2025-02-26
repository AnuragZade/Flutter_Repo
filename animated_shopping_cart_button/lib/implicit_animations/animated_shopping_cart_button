import 'package:flutter/material.dart';

class AnimatedShoppingCartButton extends StatefulWidget {
  const AnimatedShoppingCartButton({super.key});

  @override
  State<AnimatedShoppingCartButton> createState() =>
      _AnimatedShoppingCartButtonState();
}

class _AnimatedShoppingCartButtonState
    extends State<AnimatedShoppingCartButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });   
          },
          child: AnimatedContainer(
            height: 60,
            width: isTapped ? 200 : 60,
            duration: Duration(milliseconds: 2000),
            curve: Curves.fastEaseInToSlowEaseOut,

            decoration: BoxDecoration(
              borderRadius:
                  isTapped
                      ? BorderRadius.circular(30)
                      : BorderRadius.circular(12),
              color: isTapped ? Colors.green : Colors.blueGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  isTapped ? Icons.check : Icons.shopping_cart,
                  color: Colors.white,
                ),
                if (isTapped)
                  Text(
                    "Added to cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
