import 'dart:async';

class Validators {
  static final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError(
          'Correo incorrecto',
        );
      }
    },
  );

  static final validatePassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 8) {
        sink.add(password);
      } else {
        sink.addError(
          'Debes ingresar la contraseña',
        );
      }
    },
  );
  static final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isNotEmpty) {
        sink.add(name);
      } else {
        sink.addError(
          'Nombre no valido',
        );
      }
    },
  );
  static final validateConfirmPasword =
      StreamTransformer<List<String>, String>.fromHandlers(
    handleData: (password, sink) {
      if (password[0] == password[1]) {
        sink.add(password[1]);
      } else {
        sink.addError(
          'Las contraseñas no conciden',
        );
      }
    },
  );
  static final validateTerms = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (termsCheck, sink) {
      if (termsCheck == true) {
        sink.add(termsCheck);
      } else {
        sink.addError(
          'Debes aceptar los terminos y condiciones',
        );
      }
    },
  );
}
