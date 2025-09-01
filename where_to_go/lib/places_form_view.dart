import "dart:io";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:image_picker/image_picker.dart";
import "features/auth/tokens_provider.dart";
import "features/database/dream_place_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart" show ThemePalette;

class PlacesFormView extends ConsumerStatefulWidget {
  const PlacesFormView({super.key});

  @override
  ConsumerState<PlacesFormView> createState() => _PlacesFormViewState();
}

class _PlacesFormViewState extends ConsumerState<PlacesFormView> {
  final _formKey = GlobalKey<FormState>();

  String? _notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }

  File? _pickedImage;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Helper to pick image
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _pickedImage = File(picked.path);
        });
      }
    } on Object catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image picker error: $e")),
      );
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) || _pickedImage == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and select an image.")),
      );
      return;
    }

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    try {
      final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
      final tokens = await ref.watch(tokensProvider.future);
      final accessToken = tokens.$1;

      repo.dio.options.headers = {
        "Authorization": "Bearer $accessToken",
      };

      // Upload image file
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_pickedImage!.path),
      });

      Response<Map<String, dynamic>> photoResponse;
      try {
        photoResponse = await repo.dio.post<Map<String, dynamic>>("/photos/upload", data: formData);
      } on DioException catch (dioErr) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Photo upload failed: ${dioErr.message}")));
        return;
      } on Object catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Photo upload failed: $e")));
        return;
      }

      // Use the returned photo reference for imageUrl
      final imageUrl = photoResponse.data?["filename"] as String?;

      try {
        await repo.dio.post<Map<String, dynamic>>(
          "/places",
          data: {
            "name": name,
            "description": description,
            "imageUrl": imageUrl,
            "isFavourite": false,
          },
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Place created successfully")),
        );
      } on DioException catch (dioErr) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to create place: ${dioErr.message}")));
        return;
      } on Object catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create place: $e")),
        );
        return;
      }

      ref.invalidate(dreamPlacesProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
    } on Object catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create place: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    final palette = ThemePalette();

    return themeAsync.when(
      data: (currentTheme) {
        final primaryColor = palette.getPrimaryColor(currentTheme, context);
        final secondaryColor = palette.getSecondaryColor(currentTheme, context);

        InputDecoration themedDecoration(String label) => InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: secondaryColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            );

        final textStyle = TextStyle(color: secondaryColor);

        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("Add Dreamspace",
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            iconTheme: IconThemeData(color: secondaryColor),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: themedDecoration("Name"),
                    style: textStyle,
                    textInputAction: TextInputAction.next,
                    validator: _notEmptyValidator,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: themedDecoration("Description"),
                    style: textStyle,
                    maxLines: 4,
                    validator: _notEmptyValidator,
                  ),
                  const SizedBox(height: 12),
                  Text("Image", style: textStyle),
                  const SizedBox(height: 8),
                  if (_pickedImage != null) Image.file(_pickedImage!, height: 120) else const Text("No image selected"),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Pick Image"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _submit,
                    icon: Icon(Icons.save, color: primaryColor),
                    label: Text("Create Dreamspace", style: TextStyle(color: primaryColor)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
