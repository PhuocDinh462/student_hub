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
  bool isHaveInfo = false;
  bool isCallApi = false;
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

  late List<String> optionsSelected;

  void _onTapSelection(BuildContext context, int index) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
    profileCompanyViewModel.company = profileCompanyViewModel.company.copyWith(
      size: index,
    );
    profileCompanyViewModel.notiListener();
  }

  void _onTapCreateProfile(BuildContext context) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);
    profileCompanyViewModel.createProfileCompany(ProfileCompanyModel(
      size: profileCompanyViewModel.company.size,
      companyName: _companyName.text,
      website: _website.text,
      description: _description.text,
    ));
  }

  void _onTapUpdateProfile(BuildContext context) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);
    profileCompanyViewModel.updateProfileCompany(ProfileCompanyModel(
      id: profileCompanyViewModel.company.id,
      companyName: _companyName.text,
      website: _website.text,
      description: _description.text,
    ));
  }

  @override
  void initState() {
    super.initState();

    optionsSelected = options;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileCompanyViewModel =
          Provider.of<ProfileCompanyViewModel>(context, listen: false);
      profileCompanyViewModel.fetchProfileCompany();
    });
  }

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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.loaderOverlay.show();
          });
          isCallApi = true;
        } else if (isCallApi) {
          _companyName.text = profileCompanyViewModel.company.companyName;
          _website.text = profileCompanyViewModel.company.website;
          _description.text = profileCompanyViewModel.company.description;
          optionsSelected = profileCompanyViewModel.company.id != -1
              ? [options[profileCompanyViewModel.company.size]]
              : options;
          isHaveInfo = profileCompanyViewModel.company.id != -1;
          isCallApi = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.loaderOverlay.hide();
            if (profileCompanyViewModel.errorMessage == 'empty') {
              Navigator.pushNamed(context, CompanyRoutes.welcomeCompany);
            }
          });
        }

        return SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            padding:
                const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 0),
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
                        overflow: TextOverflow.visible,
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
                              items: optionsSelected,
                              numSelected: profileCompanyViewModel.company.size,
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
                              onPressed: () => _onTapCreateProfile(context),
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
                              onPressed: () => _onTapUpdateProfile(context),
                              child: DisplayText(
                                text: 'Edit',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                          const Gap(15),
                          ElevatedButton(
                              style: buttonSecondary,
                              onPressed: () => Navigator.pop(context),
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
