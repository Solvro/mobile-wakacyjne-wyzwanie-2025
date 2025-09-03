import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:reactive_forms/reactive_forms.dart";
import "package:reactive_image_picker/reactive_image_picker.dart";

import "../places_providers.dart";

enum FormKeys {
  city,
  country,
  description,
  image,
}

class CreateDreamPlaceScreen extends ConsumerWidget {
  CreateDreamPlaceScreen({super.key});

  final form = fb.group({
    FormKeys.city.name: ["", Validators.required],
    FormKeys.country.name: ["", Validators.required],
    FormKeys.description.name: ["", Validators.required],
    FormKeys.image.name: FormControl<List<SelectedFile>>(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Dream Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildForm(context, ref),
      ),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref) {
    return CreateDreamPlaceForm(form: form);
  }
}

class CreateDreamPlaceForm extends ConsumerWidget {
  const CreateDreamPlaceForm({
    super.key,
    required this.form,
  });

  final FormGroup form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: <Widget>[
          ReactiveTextField<String>(
            formControlName: FormKeys.city.name,
            decoration: const InputDecoration(labelText: "Miasto"),
          ),
          ReactiveTextField<String>(
            formControlName: FormKeys.country.name,
            decoration: const InputDecoration(labelText: "Kraj"),
          ),
          ReactiveTextField<String>(
            formControlName: FormKeys.description.name,
            decoration: const InputDecoration(labelText: "Opis"),
          ),
          ReactiveImagePicker(
            formControlName: FormKeys.image.name,
            decoration: const InputDecoration(labelText: "Obraz"),
            modes: const [ImagePickerMode.cameraImage, ImagePickerMode.galleryImage],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (form.valid) {
                final city = form.control(FormKeys.city.name).value as String;
                final country = form.control(FormKeys.country.name).value as String;
                final description = form.control(FormKeys.description.name).value as String;
                final image = form.control(FormKeys.image.name).value as List<SelectedFile>;

                try {
                  final repo = ref.read(repositoryProvider);
                  await repo.addPlaceFromForm(
                    city: city,
                    country: country,
                    description: description,
                    imageFile: image.first.file!,
                  );

                  log("Created place: $city, $country, $description");

                  if (!context.mounted) {
                    return;
                  }
                  ref.invalidate(allPlacesProvider);
                  context.pop();
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to create place: $e")),
                  );
                }
              } else {
                form.markAllAsTouched();
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}
