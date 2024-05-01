import 'dart:convert';

import 'package:mobile_test_project/utils/null_mapper.dart';


List<RecipesModel> recipesModelFromJson(String str) => List<RecipesModel>.from(json.decode(str).map((x) => RecipesModel.fromJson(x)));

String recipesModelToJson(List<RecipesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipesModel {
  final String? id;
  final String? fats;
  final String? name;
  final String? time;
  final String? image;
  final List<String>? weeks;
  final String? carbos;
  final String? fibers;
  final double? rating;
  final String? country;
  final int? ratings;
  final String? calories;
  final String? headline;
  final List<String>? keywords;
  final List<String>? products;
  final String? proteins;
  final int? favorites;
  final int? difficulty;
  final String? description;
  final bool? highlighted;
  final List<String>? ingredients;
  final dynamic incompatibilities;
  final List<String>? deliverableIngredients;
  final List<dynamic>? undeliverableIngredients;

  RecipesModel({
    this.id,
    this.fats,
    this.name,
    this.time,
    this.image,
    this.weeks,
    this.carbos,
    this.fibers,
    this.rating,
    this.country,
    this.ratings,
    this.calories,
    this.headline,
    this.keywords,
    this.products,
    this.proteins,
    this.favorites,
    this.difficulty,
    this.description,
    this.highlighted,
    this.ingredients,
    this.incompatibilities,
    this.deliverableIngredients,
    this.undeliverableIngredients,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
        id: json.value<String>(json["id"]),
        fats: json.value<String>(json["fats"]),
        name: json.value<String>(json["name"]),
        time: json.value<String>(json["time"]),
        image: json.value<String>(json["image"]),
        weeks: json["weeks"] == null ? [] : List<String>.from(json["weeks"]!.map((item) => item)),
        carbos: json.value<String>(json["carbos"]),
        fibers: json.value<String>(json["fibers"]),
        rating: json.value<double>(json["rating"]),
        country: json.value<String>(json["country"]),
        ratings: json.value<int>(json["ratings"]),
        calories: json.value<String>(json["calories"]),
        headline: json.value<String>(json["headline"]),
        keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x)),
        products: json["products"] == null ? [] : List<String>.from(json["products"]!.map((x) => x)),
        proteins: json.value<String>(json["proteins"]),
        favorites: json.value<int>(json["favorites"]),
        difficulty: json.value<int>(json["difficulty"]),
        description: json.value<String>(json["description"]),
        highlighted: json.value<bool>(json["highlighted"]),
        ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
        incompatibilities: json.value<String>(json["incompatibilities"]),
        deliverableIngredients:
            json["deliverable_ingredients"] == null ? [] : List<String>.from(json["deliverable_ingredients"]!.map((x) => x)),
        undeliverableIngredients:
            json["undeliverable_ingredients"] == null ? [] : List<dynamic>.from(json["undeliverable_ingredients"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fats": fats,
        "name": name,
        "time": time,
        "image": image,
        "weeks": weeks == null ? [] : List<dynamic>.from(weeks!.map((x) => x)),
        "carbos": carbos,
        "fibers": fibers,
        "rating": rating,
        "country": country,
        "ratings": ratings,
        "calories": calories,
        "headline": headline,
        "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
        "proteins": proteins,
        "favorites": favorites,
        "difficulty": difficulty,
        "description": description,
        "highlighted": highlighted,
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x)),
        "incompatibilities": incompatibilities,
        "deliverable_ingredients": deliverableIngredients == null ? [] : List<dynamic>.from(deliverableIngredients!.map((x) => x)),
        "undeliverable_ingredients": undeliverableIngredients == null ? [] : List<dynamic>.from(undeliverableIngredients!.map((x) => x)),
      };
}
