// lib/screens/add_place_dialog.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/favorite/favorite_provider.dart";
import "../models/dream_place.dart";
import "../providers/http_client_provider.dart";

class AddPlaceDialog extends ConsumerStatefulWidget {
  const AddPlaceDialog({super.key});

  @override
  ConsumerState<AddPlaceDialog> createState() => _AddPlaceDialogState();
}

class _AddPlaceDialogState extends ConsumerState<AddPlaceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();

  var _isFavorite = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dodaj miejsce marzeń"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nazwa",
                  hintText: "Wenecja",
                ),
                validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: "Opis",
                  hintText: "Piękne miejsce na ziemi",
                ),
                validator: (value) => value == null || value.isEmpty ? "Podaj opis" : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "URL obrazka",
                  hintText: "https://example.com/image.jpg",
                ),
                validator: (value) => value == null || value.isEmpty ? "Podaj link obrazu" : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text("Ulubione"),
                  const Spacer(),
                  Checkbox(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() => _isFavorite = value ?? false);
                      ref.read(favoriteProvider.notifier).toggle();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Anuluj"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            // 👇 CHWYTAMY Navigator PRZED await – brak użycia BuildContext po await
            final navigator = Navigator.of(context);

            final newPlace = DreamPlace(
              name: _nameController.text,
              description: _descController.text,
              imageUrl: _imageController.text,
              isFavorite: _isFavorite,
            );

            final repo = ref.read(dreamPlaceRepositoryProvider);

            await repo.addDreamPlace(newPlace);

            // Pokazujemy nowe miejsce po dodaniu
            navigator.pop(newPlace);
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }
}
