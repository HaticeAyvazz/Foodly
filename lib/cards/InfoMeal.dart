import 'package:flutter/material.dart';
import 'package:foodly/models/meal_model.dart';
import 'package:foodly/services/favorite_service.dart';

class InfoMeal extends StatelessWidget {
  final Meal meal;

  const InfoMeal({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  meal.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                meal.name,
                style: TextStyle(fontSize: 20, color: Colors.blue.shade400),
              ),
              SizedBox(height: 7),
              Text(meal.category, style: TextStyle(fontSize: 12)),

              SizedBox(height: 50),
              Text(
                "Ingredients",
                style: TextStyle(
                  color: Colors.blue.shade400,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                    leading: Icon(Icons.done, color: Colors.blueGrey),
                    title: Text(meal.ingredients[index]),
                  );
                },
              ),
              SizedBox(height: 30),
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.blue.shade400,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              Text(meal.instructions, style: TextStyle(fontSize: 16)),

              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  await FavoriteService().addFavorite(
                    id: meal.id,
                    name: meal.name,
                    imageUrl: meal.imageUrl,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${meal.name} favorilere eklendi.")),
                  );
                },
                child: Text("Add Favorite"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  elevation: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
