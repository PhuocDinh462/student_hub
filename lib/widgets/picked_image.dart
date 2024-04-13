import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class PickedImage extends StatefulWidget {
  const PickedImage(
      {super.key,
      required this.label,
      required this.ps,
      this.urlFile,
      required this.actionUpdate});
  final String label;
  final ProfileStudentViewModel ps;
  final String? urlFile;
  final Function(int, File?) actionUpdate;

  @override
  State<PickedImage> createState() => _PickedImageState();
}

class _PickedImageState extends State<PickedImage> {
  FilePickerResult? result;
  String? fileName;
  String? extension;
  PlatformFile? pickedfile;
  File? fileToDisplay;

  @override
  void initState() {
    super.initState();

    if (widget.urlFile != null) {
      fileName = Helpers.getFileNameAndExtension(widget.urlFile!)[0];
      extension = Helpers.getFileNameAndExtension(widget.urlFile!)[1];
    }
  }

  bool isLoading = false;
  bool isFilePdf = false;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = (await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf']))!;
      if (result != null) {
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());

        fileName = Helpers.getFileNameAndExtension(widget.urlFile!)[0];
        extension = Helpers.getFileNameAndExtension(widget.urlFile!)[1];

        widget.actionUpdate(2, fileToDisplay!);
      }
    } catch (e) {
      // print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorScheme.onSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DisplayText(text: widget.label, style: textTheme.bodyLarge!),
          const Gap(5),
          DottedBorder(
            strokeWidth: 1,
            color: primary_300,
            dashPattern: const [10, 6],
            child: GestureDetector(
              onTap: () {
                pickFile();
              },
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : fileName == null
                      ? Container(
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
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: deviceSize.width * 0.5,
                                child: DisplayText(
                                  text: fileName!,
                                  style: textTheme.labelMedium!,
                                ),
                              ),
                              SizedBox(
                                width: deviceSize.width * 0.1,
                                child: DisplayText(
                                  text: '.${extension!}',
                                  style: textTheme.labelMedium!,
                                ),
                              ),
                              Row(
                                children: [
                                  ButtonIconRetangle(
                                      icon: Icons.change_circle,
                                      onPressed: () {
                                        pickFile();
                                      }),
                                  const Gap(10),
                                  ButtonIconRetangle(
                                      icon: Icons.remove_red_eye_rounded,
                                      onPressed: () {})
                                ],
                              )
                            ],
                          )),
            ),
          ),
        ],
      ),
    );
  }
}
