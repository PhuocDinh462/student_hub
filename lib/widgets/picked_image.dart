import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class PickedImage extends StatefulWidget {
  const PickedImage({super.key, required this.label});
  final String label;
  @override
  State<PickedImage> createState() => _PickedImageState();
}

class _PickedImageState extends State<PickedImage> {
  FilePickerResult? result;
  String? fileName;
  PlatformFile? pickedfile;
  File? fileToDisplay;
  bool isLoading = false;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = (await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']))!;
      if (result != null) {
        fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(text: widget.label, style: textTheme.bodyLarge!),
        const Gap(5),
        DottedBorder(
          strokeWidth: 1,
          color: primary_300,
          dashPattern: const [10, 6],
          child: pickedfile != null
              ? SizedBox(
                  height: 200,
                  width: deviceSize.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 140,
                          width: deviceSize.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(fileToDisplay!),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Container(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: deviceSize.width * 0.6,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primary_300,
                                  ),
                                  borderRadius: BorderRadius.circular(2)),
                              child: DisplayText(
                                  text: fileName!,
                                  style: textTheme.labelSmall!),
                            ),
                            IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  pickFile();
                                },
                                icon: const Icon(
                                  Icons.change_circle,
                                  color: primary_300,
                                )),
                          ],
                        ),
                      ]),
                )
              : GestureDetector(
                  onTap: () {
                    pickFile();
                  },
                  child: Container(
                    height: 200,
                    width: deviceSize.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/upload.jpg'),
                      fit: BoxFit.contain,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DisplayText(
                          text: 'Choose file to Upload',
                          style: textTheme.labelMedium!
                              .copyWith(color: primary_300),
                        ),
                        const Gap(15)
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
