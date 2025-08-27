import "package:flutter/material.dart";

import "../../app/persistance/database/tables/attractions.dart";
import "../../data/models/attraction.dart";

Attraction attractionFromValue(AttractionValue value) {
  switch (value) {
    case AttractionValue.mountains:
      return const Attraction("Mountains", Icons.terrain);
    case AttractionValue.water:
      return const Attraction("Water", Icons.water);
    case AttractionValue.beach:
      return const Attraction("Beach", Icons.beach_access);
    case AttractionValue.landscapes:
      return const Attraction("Landscapes", Icons.landscape);
    case AttractionValue.sunsets:
      return const Attraction("Sunsets", Icons.wb_sunny);
    case AttractionValue.history:
      return const Attraction("History", Icons.account_balance);
    case AttractionValue.culture:
      return const Attraction("Culture", Icons.theater_comedy);
    case AttractionValue.walks:
      return const Attraction("Walks", Icons.directions_walk);
    case AttractionValue.food:
      return const Attraction("Food", Icons.restaurant);
    case AttractionValue.views:
      return const Attraction("Views", Icons.remove_red_eye);
  }
}

AttractionValue valueFromAttraction(Attraction attraction) {
  switch (attraction.title.toLowerCase()) {
    case "mountains":
      return AttractionValue.mountains;
    case "water":
      return AttractionValue.water;
    case "beach":
      return AttractionValue.beach;
    case "landscapes":
      return AttractionValue.landscapes;
    case "sunsets":
      return AttractionValue.sunsets;
    case "history":
      return AttractionValue.history;
    case "culture":
      return AttractionValue.culture;
    case "walks":
      return AttractionValue.walks;
    case "food":
      return AttractionValue.food;
    case "views":
      return AttractionValue.views;
    default:
      throw Exception("Unknown attraction: ${attraction.title}");
  }
}
