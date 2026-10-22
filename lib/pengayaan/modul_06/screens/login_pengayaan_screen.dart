
import 'package:flutter/material.dart';

import '../../../modul_06/services/auth_api.dart';
import '../../../modul_06/widgets/field_kata_sandi.dart';
import '../controllers/sesi_controller.dart';

class LoginPengayaanScreen extends StatefulWidget {
  final SesiController controller;

  const LoginPengayaanScreen({
    super.key,
    required this.controller,
  });

  @override
  State<LoginPengayaanScreen> createState() =>
      _LoginPengayaanScreenState();
}

class _LoginPengayaanScreenState
    extends State<LoginPengayaanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _sandi = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _sandi.dispose();
    super.dispose();
  }

  String? _validasiEmail(String? nilai) {
    final String email = nilai?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email wajib diisi.';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Masukkan alamat email yang valid.';
    }

    return null;
  }

  String? _validasiSandi(String? nilai) {
    if (nilai == null || nilai.isEmpty) {
      return 'Kata sandi wajib diisi.';
    }

    if (nilai.length < 8) {
      return 'Kata sandi minimal 8 karakter.';
    }

    return null;
  }

  Future<void> _kirim() async {
    if (widget.controller.status == StatusSesi.memproses) {
      return;
    }

    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    await widget.controller.masuk(
      email: _email.text.trim(),
      sandi: _sandi.text,
    );

    if (!mounted) return;

    if (widget.controller.status == StatusSesi.masuk) {
      _sandi.clear();
    }
  }

  void _isiAkunDemo() {
    setState(() {
      _email.text = AuthApi.emailDemo;
      _sandi.text = AuthApi.sandiDemo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (BuildContext context, Widget? child) {
        final bool sedangMemproses =
            widget.controller.status == StatusSesi.memproses;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 56,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Masuk ke Aplikasi',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pengayaan Modul 06: Penyimpanan Sesi',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _email,
                      enabled: !sedangMemproses,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      autofillHints: const <String>[
                        AutofillHints.email,
                      ],
                      validator: _validasiEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'nama@contoh.com',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    FieldKataSandi(
                      controller: _sandi,
                      enabled: !sedangMemproses,
                      textInputAction: TextInputAction.done,
                      validator: _validasiSandi,
                      onSubmitted: _kirim,
                    ),
                    if (widget.controller.pesan != null) ...<Widget>[
                      const SizedBox(height: 12),
                      Text(
                        widget.controller.pesan!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: sedangMemproses ? null : _kirim,
                      icon: sedangMemproses
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.login_rounded),
                      label: Text(
                        sedangMemproses ? 'Memproses...' : 'Masuk',
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed:
                          sedangMemproses ? null : _isiAkunDemo,
                      child: const Text('Isi Akun Demo'),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Akun demo: ${AuthApi.emailDemo}\n'
                      'Kata sandi: ${AuthApi.sandiDemo}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
