part of "../login_page.dart";

class _LoginRegisterButtons extends StatelessWidget {
  _LoginRegisterButtons();

  final controller = Modular.get<IUserService>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        CuidapetRoundedButtonWithIcon(
          onTap: () {
            controller.socialLogin(type: SocialLoginType.facebook);
          }, 
          width: 0.42.sw, 
          color: const Color(0xFF4267B3), 
          icon: CuidapetIcons.facebook, 
          label: "Facebook",
        ),
        CuidapetRoundedButtonWithIcon(
          onTap: () {
            controller.socialLogin(type: SocialLoginType.google);
          }, 
          width: 0.42.sw, 
          color: const Color(0xFFE15031), 
          icon: CuidapetIcons.google, 
          label: "Google",
        ),
        CuidapetRoundedButtonWithIcon(
          onTap: () {
            Navigator.pushNamed(context, "/auth/register");
          }, 
          width: 0.42.sw, 
          color: context.primaryColorDark, 
          icon: CuidapetIcons.mail_alt, 
          label: "Cadastre-se",
        ),
      ],
    );
  }
}