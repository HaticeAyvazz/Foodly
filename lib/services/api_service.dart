import 'package:dio/dio.dart';
import 'package:foodly/models/meal_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Meal?> fetchMeal(String query) async {
    try {
      final response = await _dio.get(
        "https://www.themealdb.com/api/json/v1/1/search.php",
        queryParameters: {"s": query},
      );
      if (response.statusCode == 200) {
        final data = response.data['meals'];
        if (data != null && data.isNotEmpty) {
          return Meal.fromJson(data[0]);
        }
      } else {
        throw Exception("Can not meal");
      }
    } catch (e) {
      throw Exception("API exception $e");
    }
  }
}
