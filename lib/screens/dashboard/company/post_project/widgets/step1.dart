import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';

class Step1 extends StatelessWidget {
  Step1({super.key, required this.next});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider postJobProvider =
        Provider.of<ProjectProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("1/4\t\t\t\t\tLet's start with a strong title",
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: Image.asset(
              'assets/images/Hand-coding.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          const Text(
            'This helps your post stand out to the right students. '
            "It's the first thing they'll see, so make it impressive!",
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          TextFormField(
            initialValue: postJobProvider.getTitle,
            onChanged: (value) => postJobProvider.setTitle = value,
            scrollPadding: const EdgeInsets.only(bottom: double.infinity),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your title',
              contentPadding: EdgeInsets.all(15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: text_500,
                  width: 1,
                ),
              ),
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) next();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary_300,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: text_50,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
