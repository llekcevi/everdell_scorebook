import 'package:flutter/material.dart';

BoxDecoration backgroundImage() {
  return BoxDecoration(
    image: DecorationImage(
        image: Image.asset('assets/big.jpg').image, fit: BoxFit.fitHeight),
  );
}

BoxDecoration backgroundGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [Colors.black12, Colors.black54],
    ),
  );
}
