// import "package:flutter/cupertino.dart";
// import "package:flutter/material.dart";

// import "../app/colors.dart";
// import "../app/ui_config.dart";
// import "../models/dream_place.dart";

// class DreamPlaceScreenHookWidget extends StatefulWidget {
//   const DreamPlaceScreenHookWidget({super.key, required this.dreamPlace});

//   final DreamPlace dreamPlace;

//   @override
//   State<DreamPlaceScreenHookWidget> createState() => _DreamPlaceScreenHookWidgetState();
// }

// class _DreamPlaceScreenHookWidgetState extends State<DreamPlaceScreenHookWidget> {
//   bool _isFavorited = false;

//   @override
//   void initState() {
//     super.initState();
//     _isFavorited = widget.dreamPlace.isFavorited;
//   }

//   void _toggleFavourited() {
//     setState(() {
//       _isFavorited = !_isFavorited;
//       widget.dreamPlace.isFavorited = _isFavorited;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(widget.dreamPlace.location),
//         actions: [
//           IconButton(
//               onPressed: _toggleFavourited, icon: Icon(_isFavorited ? CupertinoIcons.heart_fill : CupertinoIcons.heart))
//         ],
//       ),
//       backgroundColor: AppColors.backgroundColor,
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(fit: BoxFit.fitWidth, widget.dreamPlace.imagePath, width: double.infinity),
//           Padding(
//             padding: const EdgeInsets.all(AppPaddings.large),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.dreamPlace.title,
//                   style: const TextStyle(
//                     fontSize: DreamPlaceScreenConfig.titleFontSize,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: AppPaddings.small,
//                 ),
//                 Text(widget.dreamPlace.description,
//                     style: const TextStyle(
//                       fontSize: DreamPlaceScreenConfig.descriptionFontSize,
//                       color: AppColors.secondaryTextColor,
//                     )),
//               ],
//             ),
//           ),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: widget.dreamPlace.attractions.map((attraction) {
//                 return Column(
//                   children: [
//                     Icon(attraction.icon, size: DreamPlaceScreenConfig.iconSize),
//                     Text(attraction.title),
//                   ],
//                 );
//               }).toList())
//         ],
//       ),
//     );
//   }
// }
