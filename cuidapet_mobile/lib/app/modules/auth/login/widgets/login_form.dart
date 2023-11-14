part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {

  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _controller = Modular.get<LoginController>();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            controller: _emailEC,
            label: "Email",
            validator: Validatorless.multiple([
              Validatorless.required("Email obrigatório"),
              Validatorless.email("Deve ser um email válido"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            controller: _passwordEC,
            label: "Senha",
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("Senha obrigatória"),
              Validatorless.min(6, "Senha precisa ter pelo menos 6 caracteres"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            label: "Entrar",
            onPressed: () async {

              final formValid = _formKey.currentState?.validate() ?? false;

              if(formValid) {
                await _controller.login(
                  email: _emailEC.text,
                  password: _passwordEC.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}