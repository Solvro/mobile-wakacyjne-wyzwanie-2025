import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../../../app/ui_config.dart";

class ReactiveImagePicker extends ReactiveFormField<File, File> {
  final Decoration? decoration;
  final TextStyle? errorTextStyle;
  ReactiveImagePicker({super.key, required String formControlName, this.decoration, this.errorTextStyle})
      : super(
          formControlName: formControlName,
          validationMessages: {
            ValidationMessage.required: (_) => "Image is required",
          },
          builder: (field) {
            final image = field.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Image", style: Theme.of(field.context).textTheme.titleSmall),
                const SizedBox(height: AppPaddings.small),
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      field.didChange(File(picked.path));
                    }
                  },
                  child: Container(
                    height: CreatePlaceViewConfig.imageFieldHeight,
                    width: double.infinity,
                    decoration: decoration,
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(CreatePlaceViewConfig.radius),
                            child: Image.file(image, fit: BoxFit.cover))
                        : const Center(child: Text("Tap to select image")),
                  ),
                ),
                if (field.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppPaddings.small),
                    child: Text(field.errorText ?? "", style: errorTextStyle),
                  ),
              ],
            );
          },
        );
}
