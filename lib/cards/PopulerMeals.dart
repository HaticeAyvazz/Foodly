import 'package:flutter/material.dart';
import 'package:foodly/services/favorite_service.dart';

class PopulerMeals extends StatelessWidget {
  const PopulerMeals({super.key});

  Widget _mealCard({
    required BuildContext context,
    required String image,
    required String name,
  }) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(0),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.bottomLeft,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () async {
                await FavoriteService().addFavorite(
                  id: name,
                  name: name,
                  imageUrl: image,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$name favorilere eklendi")),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Meals",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 0),
            itemBuilder: (_, i) {
              if (i == 0) {
                return _mealCard(
                  context: context,
                  image: "assets/images/cheescake.jpg",
                  name: "Butter Cheescake",
                );
              } else if (i == 1) {
                return _mealCard(
                  context: context,
                  image: "assets/images/pizza.jpg",
                  name: "Pizza",
                );
              } else {
                return _mealCard(
                  context: context,
                  image: "assets/images/fettucino.jpg",
                  name: "Fettucino",
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
