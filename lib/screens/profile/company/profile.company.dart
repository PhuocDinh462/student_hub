import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late AppLocalizations? appLocal;

  List<String> options = [];

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

    profileCompanyViewModel
        .createProfileCompany(ProfileCompanyModel(
      size: profileCompanyViewModel.company.size,
      companyName: _companyName.text,
      website: _website.text,
      description: _description.text,
    ))
        .then((value) {
      hanldeUpdateCurrentUser();
    });
  }

  void _onTapUpdateProfile(BuildContext context) {
    final profileCompanyViewModel =
        Provider.of<ProfileCompanyViewModel>(context, listen: false);
    profileCompanyViewModel
        .updateProfileCompany(ProfileCompanyModel(
      id: profileCompanyViewModel.company.id,
      companyName: _companyName.text,
      website: _website.text,
      description: _description.text,
    ))
        .then((value) {
      hanldeUpdateCurrentUser();
    });
  }

  Future<void> hanldeUpdateCurrentUser() async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      final userInfo = await authService.getMe();
      final companyId =
          userInfo['company'] != null ? userInfo['company']['id'] : null;
      final studentId =
          userInfo['student'] != null ? userInfo['student']['id'] : null;
      List<Role> roles = [];

      for (var role in userInfo['roles']) {
        roles.add(role == 0 ? Role.student : Role.company);
      }

      Role currentRole =
          userInfo['roles'][0] == 0 ? Role.student : Role.company;

      User currentUser = User(
        userId: userInfo['id'],
        fullname: userInfo['fullname'],
        roles: roles,
        currentRole: currentRole,
        companyId: companyId,
        studentId: studentId,
      );
      userProvider.setCurrentUser(currentUser);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocal = AppLocalizations.of(context);
    options.add(appLocal!.optionsEmployees1);
    options.add(appLocal!.optionsEmployees2);
    options.add(appLocal!.optionsEmployees3);
    options.add(appLocal!.optionsEmployees4);
    options.add(appLocal!.optionsEmployees5);
    optionsSelected = options;
  }

  @override
  void initState() {
    super.initState();

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
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);

    if (appLocal == null) {
      return const Column(children: [
        Gap(30),
        CircularProgressIndicator(),
      ]);
    } else {
      return GestureDetector(onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }, child: Scaffold(
        body: Consumer<ProfileCompanyViewModel>(
            builder: (context, profileCompanyViewModel, child) {
          if (profileCompanyViewModel.loading) {
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
              if (profileCompanyViewModel.errorMessage == 'empty') {
                if (user.currentUser!.currentRole == Role.student) {
                  Get.toNamed(StudentRoutes.welcomeCompany, arguments: {
                    'appLocal': appLocal,
                  });
                } else {
                  Get.toNamed(CompanyRoutes.welcomeCompany, arguments: {
                    'appLocal': appLocal,
                  });
                }
              }
            });
          }

          return SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 0),
              child: profileCompanyViewModel.loading
                  ? const Column(children: [
                      Gap(30),
                      CircularProgressIndicator(),
                    ])
                  : Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            child: DisplayText(
                              text: appLocal!.welcomeStudentHub,
                              style: textTheme.displayLarge!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            )),
                        if (!isHaveInfo)
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 17, right: 17),
                              child: DisplayText(
                                text: appLocal!.descriptionCompany,
                                style: textTheme.bodySmall!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              )),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  verticalDirection: isHaveInfo
                                      ? VerticalDirection.up
                                      : VerticalDirection.down,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10, top: 30),
                                            child: DisplayText(
                                              text: appLocal!.howManyPeople,
                                              style: textTheme.bodyLarge!,
                                            )),
                                        DisplayRadioList(
                                          items: optionsSelected,
                                          numSelected: profileCompanyViewModel
                                              .company.size,
                                          onChange: isHaveInfo
                                              ? null
                                              : _onTapSelection,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Column(children: [
                                        CommonTextField(
                                          title: appLocal!.companyName,
                                          hintText: appLocal!.yourCompany,
                                          controller: _companyName,
                                        ),
                                        const Gap(20),
                                        CommonTextField(
                                          title: appLocal!.website,
                                          hintText: appLocal!.yourWebsite,
                                          controller: _website,
                                        ),
                                        const Gap(20),
                                        CommonTextField(
                                          title: appLocal!.description,
                                          hintText: appLocal!.yourDescription,
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
                                          onPressed: () =>
                                              _onTapCreateProfile(context),
                                          child: DisplayText(
                                            text: appLocal!.continute,
                                            style:
                                                textTheme.labelLarge!.copyWith(
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
                                          onPressed: () =>
                                              _onTapUpdateProfile(context),
                                          child: DisplayText(
                                            text: appLocal!.edit,
                                            style:
                                                textTheme.labelLarge!.copyWith(
                                              color: Colors.white,
                                            ),
                                          )),
                                      const Gap(15),
                                      ElevatedButton(
                                          style: buttonSecondary,
                                          onPressed: () => Get.toNamed(
                                              StudentRoutes.account),
                                          child: DisplayText(
                                            text: appLocal!.cancel,
                                            style:
                                                textTheme.labelLarge!.copyWith(
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
}
