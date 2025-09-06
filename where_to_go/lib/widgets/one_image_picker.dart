import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:reactive_forms/reactive_forms.dart";

class OneImagePicker extends ReactiveFormField<File, File> {
  final String validationMessage;
  OneImagePicker({required String formControlname, required this.validationMessage})
      : super(
            formControlName: formControlname,
            validationMessages: {ValidationMessage.required: (_) => validationMessage},
            builder: (img) {
              final image = img.value;
              return GestureDetector(
                  onTap: () async {
                    final chosenImg = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (chosenImg != null) img.didChange(File(chosenImg.path));
                  },
                  child: SizedBox(
                      height: 200,
                      width: 450,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8), child: Image.file(image, fit: BoxFit.cover))
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Icon(Icons.add_photo_alternate, size: 40), Text("Dodaj zdjęcie")])));
            });
}
