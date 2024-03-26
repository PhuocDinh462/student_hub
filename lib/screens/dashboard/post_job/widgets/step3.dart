import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/post_job_provider.dart';
import 'package:student_hub/utils/extensions.dart';

class Step3 extends StatelessWidget {
  Step3({super.key, required this.next, required this.back});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback next;
  final VoidCallback back;

  @override
  Widget build(BuildContext context) {
    final PostJobProvider postJobProvider =
        Provider.of<PostJobProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('3/4\t\t\t\t\tNext, provide project description',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(20),
          Center(
            child: Image.asset(
              'assets/images/Detailed-analysis.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          const Gap(20),
          TextFormField(
            initialValue: postJobProvider.getDescription,
            onChanged: (value) => postJobProvider.setDescription = value,
            maxLines: 10,
            scrollPadding: const EdgeInsets.only(bottom: double.infinity),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Describe your project',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? text_800
                            : text_300,
                  ),
                  onPressed: () => back(),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Gap(15),
              SizedBox(
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
            ],
          ),
        ],
      ),
    );
  }
}
