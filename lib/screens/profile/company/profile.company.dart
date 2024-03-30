import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/profile/profile.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileCompanyInput extends StatefulWidget {
  const ProfileCompanyInput({super.key});

  @override
  ProfileCompanyInputState createState() => ProfileCompanyInputState();
}

class ProfileCompanyInputState extends State<ProfileCompanyInput> {
  bool isHaveInfo = true;
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _website = TextEditingController();
  final TextEditingController _description = TextEditingController();

  List<String> options = [
    'It\'s just me',
    '2-9 employees',
    '10-99 employees',
    '100-1000 employees',
    'More than 1000 employees',
  ];

  void _onTapSelection(BuildContext context, int index) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);
    profileCompanyViewModel.company.setSize(index);
    profileCompanyViewModel.notiListener();
  }

  void _onTapSubmit(BuildContext context) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);
    profileCompanyViewModel.createProfileCompany(ProfileCompany(
      size: profileCompanyViewModel.company.size,
      companyName: _companyName.text,
      website: _website.text,
      description: _description.text,
    ));
  }

  // @override
  // void initState() {
  //   super.initState();

  //   final profileCompanyViewModel =
  //       Provider.of<ProfileCompanyViewModel>(context, listen: false);
  // }

  @override
  void dispose() {
    _companyName.dispose();
    _website.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    return GestureDetector(onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }, child: Scaffold(
      body: Consumer<ProfileCompanyViewModel>(
          builder: (context, profileCompanyViewModel, child) {
        if (profileCompanyViewModel.loading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();

          if (profileCompanyViewModel.errorMessage == 'empty') {
            Navigator.pushReplacementNamed(
                context, CompanyRoutes.welcomeCompany);
          }
        }

        return SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            padding:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: DisplayText(
                      text: 'Welcome to Student Hub',
                      style: textTheme.displayLarge!,
                    )),
                if (!isHaveInfo)
                  Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 17, right: 17),
                      child: DisplayText(
                        text:
                            'Tell us about your company and you will be on your way connect with high-skilled students.',
                        style: textTheme.bodySmall!,
                        textAlign: TextAlign.center,
                      )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                      verticalDirection: isHaveInfo
                          ? VerticalDirection.up
                          : VerticalDirection.down,
                      children: [
                        Column(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 30),
                                child: DisplayText(
                                  text: 'How many people are in your company?',
                                  style: textTheme.bodyLarge!,
                                )),
                            DisplayRadioList(
                              items: options,
                              numSelected:
                                  profileCompanyViewModel.company.size ?? 0,
                              onChange: isHaveInfo ? null : _onTapSelection,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(children: [
                            CommonTextField(
                              title: 'Company name',
                              hintText: 'Your company',
                              controller: _companyName,
                            ),
                            const Gap(20),
                            CommonTextField(
                              title: 'Website',
                              hintText: 'Your website',
                              controller: _website,
                            ),
                            const Gap(20),
                            CommonTextField(
                              title: 'Description',
                              hintText: 'Your description',
                              maxLines: 3,
                              controller: _description,
                            ),
                          ]),
                        ),
                      ]),
                  const Gap(15),
                  if (!isHaveInfo)
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () => _onTapSubmit(context),
                              child: DisplayText(
                                text: 'Continue',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  if (isHaveInfo)
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () {},
                              child: DisplayText(
                                text: 'Edit',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                          const Gap(15),
                          ElevatedButton(
                              style: buttonSecondary,
                              onPressed: () {},
                              child: DisplayText(
                                text: 'Cancel',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                ]),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
