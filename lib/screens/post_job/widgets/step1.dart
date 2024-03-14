import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_hub/constants/theme.dart';

class Step1 extends StatelessWidget {
  Step1({super.key, required this.next});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("1/4\t\t\t\t\tLet's start with a strong title",
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: SvgPicture.asset(
              'assets/svg/Hand-holding-pen.svg',
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          ),
          const Text(
            'This helps your post stand out to the right students. '
            "It's the first thing they'll see, so make it impressive!",
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          TextFormField(
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
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) next();
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: text_50,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
