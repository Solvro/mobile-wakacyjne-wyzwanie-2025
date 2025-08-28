import "package:flutter/material.dart";

IconData iconMapper(String iconName) {
  return switch (iconName) {
    "local_fire_department" => Icons.local_fire_department,
    "museum" => Icons.museum,
    "music_note" => Icons.music_note,
    "beach_access" => Icons.beach_access,
    "sunny" => Icons.sunny,
    "landscape" => Icons.landscape,
    "menu_book" => Icons.menu_book,
    "nordic_walking" => Icons.nordic_walking,
    "food_bank" => Icons.food_bank,
    "coffee" => Icons.coffee,
    "waves" => Icons.waves,
    "vertical_shades_closed" => Icons.vertical_shades_closed,
    "nightlife" => Icons.nightlife,
    _ => Icons.error
  };
}
