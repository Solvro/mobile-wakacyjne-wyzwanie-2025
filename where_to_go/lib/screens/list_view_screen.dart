import 'package:flutter/material.dart';
import 'package:hello_flutter/gen/assets.gen.dart';
import 'dart:math';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/screens/dream_place_screen.dart';
import 'package:hello_flutter/screens/hook_widget.dart';
import 'package:hello_flutter/widgets/appBar_widget.dart';
import 'package:hello_flutter/screens/inheritance_widget.dart';
import 'package:hello_flutter/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/features/favorite/favorite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/features/places/places_provider.dart';

final List<DreamPlace> dreamPlacesData = [
  DreamPlace(
    title: 'Santorini',
    image: Assets.images.santorini,
    imageDescription: 'Białe miasteczko Oia',
    placeDescription:
        'Santorini to grecka wyspa znana z białych domów z niebieskimi kopułami, malowniczych widoków i romantycznych zachodów słońca.',
    activities: [
      const Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      const Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      const Activity(
        icon: Icons.surfing_rounded,
        name: 'Surfing',
        description: 'Surfing dla każdego',
      ),
      const Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
  DreamPlace(
    title: 'Rodos',
    image: Assets.images.rodos,
    imageDescription: 'Starożytne ruiny i piękne plaże',
    placeDescription:
        'Rodos to grecka wyspa znana z pięknych plaż, starożytnych ruin i urokliwych miasteczek.',
    activities: [
      const Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      const Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      const Activity(
        icon: Icons.church,
        name: 'Zabytki',
        description: 'Starożytne ruiny',
      ),
      const Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
  DreamPlace(
    title: 'Kreta',
    image: Assets.images.kreta,
    imageDescription: 'Plaża z lazurową wodą',
    placeDescription:
        'Kreta to największa grecka wyspa, znana z bogatej historii, pięknych plaż i pysznej kuchni.',
    activities: [
      const Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      const Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      const Activity(
        icon: Icons.sunny,
        name: 'Opalanie',
        description: 'Opalanie na plaży',
      ),
      const Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
];

class ListViewScreen extends ConsumerStatefulWidget {
  final Color backgroundColor;
  final String appBarTitle;
  final String appBarText;
  final Color listColor;
  final Color containerBackgroundColor;
  final Color containerShadowColor;
  final Color listItemBackgroundColor;
  final Color listItemTitleColor;
  final Color listItemSubtitleColor;
  final Color listItemTrailingIconColor;

  const ListViewScreen({
    super.key,
    this.backgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.appBarTitle = 'Wymarzone miejsca',
    this.appBarText = "Wybierz swoje miejsce na wakacje",
    this.listColor = Colors.white,
    this.containerBackgroundColor = const Color.fromRGBO(255, 255, 255, 0.06),
    this.containerShadowColor = const Color.fromRGBO(255, 255, 255, 0.06),
    this.listItemBackgroundColor = const Color.fromRGBO(255, 255, 255, 0.06),
    this.listItemTitleColor = Colors.white,
    this.listItemSubtitleColor = Colors.white,
    this.listItemTrailingIconColor = Colors.white,
  });

  @override
  ConsumerState<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends ConsumerState<ListViewScreen> {
  final List<DreamPlace> places = dreamPlacesData;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.95 > 900 ? 900 : screenWidth * 0.95;

    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBarExample(appBarTitle: widget.appBarTitle),
      backgroundColor: widget.backgroundColor,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              child: Text(
                widget.appBarText,
                style: TextStyle(
                  color: widget.listColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: containerWidth,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: widget.containerBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: widget.containerShadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: places.map((place) {
                      final imageSize = max(120.0, containerWidth * 0.3);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Material(
                          color: widget.listItemBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).pushNamed("details", extra: place);
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: place.image.image(
                                  width: imageSize * 0.5,
                                  height: imageSize * 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    place.title,
                                    style: TextStyle(
                                      color: widget.listItemTitleColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    place.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: place.isFavorite
                                        ? Colors.red
                                        : widget.listItemTitleColor,
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                place.imageDescription,
                                style: TextStyle(
                                  color: widget.listItemSubtitleColor,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: widget.listItemTrailingIconColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
