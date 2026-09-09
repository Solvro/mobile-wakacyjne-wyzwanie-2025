import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'place_model.dart';
import 'places_provider.dart';

class AddEditPlaceScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-edit-place';
  final DreamPlace? placeToEdit;

  const AddEditPlaceScreen({super.key, this.placeToEdit});

  @override
  ConsumerState<AddEditPlaceScreen> createState() => _AddEditPlaceScreenState();
}

class _AddEditPlaceScreenState extends ConsumerState<AddEditPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  late bool _isFavourite;

  bool get isEditing => widget.placeToEdit != null;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.placeToEdit?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.placeToEdit?.description ?? '');
    _imageUrlController =
        TextEditingController(text: widget.placeToEdit?.imageUrl ?? '');

    _isFavourite = widget.placeToEdit?.isFavourite ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final placeData = DreamPlace(
      id: widget.placeToEdit?.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isNotEmpty
          ? _imageUrlController.text.trim()
          : 'image.jpg',
      isFavourite: _isFavourite,
    );

    try {
      final repo = ref.read(placesRepositoryProvider);
      if (isEditing) {
        await repo.updatePlace(widget.placeToEdit!.id!, placeData);
      } else {
        await repo.createPlace(placeData);
      }
      ref.invalidate(placesProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Błąd podczas zapisu: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edytuj miejsce' : 'Dodaj nowe miejsce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nazwa miejsca'),
                validator: (v) => v == null || v.isEmpty ? 'Podaj nazwę' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Opis'),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Podaj opis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL obrazka',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Podaj URL obrazka' : null,
              ),
              const SizedBox(height: 12),

              // 4. Widget przełącznika wewnątrz formularza
              SwitchListTile(
                title: const Text('Dodaj do ulubionych'),
                value: _isFavourite,
                onChanged: (bool value) {
                  setState(() {
                    _isFavourite = value;
                  });
                },
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: _submit,
                child: Text(isEditing ? 'Zapisz zmiany' : 'Dodaj miejsce'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
