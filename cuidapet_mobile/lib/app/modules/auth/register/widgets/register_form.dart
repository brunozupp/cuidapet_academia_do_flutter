part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  final _formKey = GlobalKey<FormState>();

  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _controller = Modular.get<RegisterController>();

  @override
  void dispose() {
    _loginEC.dispose();
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
            controller: _loginEC,
            label: "Login",
            validator: Validatorless.multiple([
              Validatorless.required("Login obrigatório"),
              Validatorless.email("Login deve ser um email válido"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            label: "Senha",
            controller: _passwordEC,
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("Senha obrigatória"),
              Validatorless.min(6, "Senha precisa ter pelo menos 6 caracteres"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            label: "Confirma senha",
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("Confirma senha obrigatória"),
              Validatorless.min(6, "Confirma senha precisa ter pelo menos 6 caracteres"),
              Validatorless.compare(_passwordEC, "Senha e confirma senha não são iguais"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            label: "Cadastrar",
            onPressed: () {

              final formValid = _formKey.currentState?.validate() ?? false;

              if(formValid) {
                _controller.register(
                  email: _loginEC.text,
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