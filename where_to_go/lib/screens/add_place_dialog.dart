// add_place_dialog.dart
import "package:flutter/material.dart";

class AddPlaceDialog extends StatefulWidget {
  const AddPlaceDialog({super.key});

  @override
  State<AddPlaceDialog> createState() => _AddPlaceDialogState();
}

class _AddPlaceDialogState extends State<AddPlaceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();

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
                decoration: const InputDecoration(labelText: "Nazwa"),
                validator: (value) => value == null || value.isEmpty ? "Podaj nazwę" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Opis"),
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "URL zdjęcia (opcjonalnie)",
                ),
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
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              final entry = DreamPlacesCompanion.insert(
                name: _nameController.text,
                description: drift.Value(
                  _descController.text.isNotEmpty ? _descController.text : null,
                ),
                imageUrl: drift.Value(
                  _imageController.text.isNotEmpty ? _imageController.text : null,
                ),
              );
              Navigator.of(context).pop(entry);
            }
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }
}
