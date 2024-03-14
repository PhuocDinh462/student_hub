import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_hub/constants/theme.dart';

// ignore: constant_identifier_names
enum TimeLine { _1to3months, _3to6months }

class Step2 extends StatelessWidget {
  Step2({super.key, required this.back, required this.next});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback back;
  final VoidCallback next;
  TimeLine? _timeLine = TimeLine._1to3months;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('2/4\t\t\t\t\tNext, estimate the scope of your job',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: SvgPicture.asset(
              'assets/svg/Coding-workshop.svg',
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          ),
          const Gap(5),
          Text('How long will your project take?',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: TimeLine._1to3months,
                    groupValue: _timeLine,
                    onChanged: (value) {},
                  ),
                  const Text('1 to 3 months'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: TimeLine._3to6months,
                    groupValue: _timeLine,
                    onChanged: (value) {},
                  ),
                  const Text('3 to 6 months'),
                ],
              ),
            ],
          ),
          const Gap(20),
          Text('How many students do you want for this project?',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(20),
          TextFormField(
            scrollPadding: const EdgeInsets.only(bottom: double.infinity),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  int.tryParse(value) == null ||
                  int.parse(value) <= 0) {
                return 'Please enter a valid number';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Number of students',
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: text_300,
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
              const Gap(15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: text_50,
                    fontSize: 18,
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
