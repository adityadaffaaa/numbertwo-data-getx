import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/main_screen.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:flutter_number_2/widgets/button_secondary.dart';
import 'package:flutter_number_2/widgets/custom_appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: screenHeight * 1 / 2,
          width: screenWidth,
          child: Column(
            children: [
              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: app_typo.heading2,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  FieldInput(
                    inputCtrl: emailCtrl,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FieldInput(
                    inputCtrl: passwordCtrl,
                    isPassword: true,
                    labelText: 'Password',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ButtonPrimary(
                  color: app_color.primary, text: 'Sign In', onPressed: () {}),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: app_color.grey2.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text('Or'),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: app_color.grey2.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              ButtonSecondary(
                  borderColor: app_color.primary,
                  onPressed: () {},
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        app_img.googleIcon,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'With Google',
                        style: app_typo.titleText14
                            .copyWith(color: app_color.primary),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldInput extends StatelessWidget {
  const FieldInput({
    Key? key,
    required this.inputCtrl,
    this.isPassword = false,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController inputCtrl;
  final bool isPassword;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: app_color.black),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class RememberSection extends StatefulWidget {
  const RememberSection({super.key});

  @override
  State<RememberSection> createState() => _RememberSectionState();
}

class _RememberSectionState extends State<RememberSection> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return app_color.primary;
    }
    return app_color.primary.withOpacity(0.1);
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: app_color.secondary,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text(
          'Remember',
          style: app_typo.titleText15,
        )
      ],
    );
  }
}
