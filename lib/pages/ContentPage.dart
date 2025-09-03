import 'package:flutter/material.dart';
import 'package:foodly/cards/InfoMeal.dart';
import 'package:foodly/models/meal_model.dart';

class ContentPage extends StatelessWidget {
  final Meal meal;
  const ContentPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Foodly",
          style: TextStyle(color: Colors.blueGrey.shade600),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [InfoMeal(meal: meal)]),
      ),
    );
  }
}
