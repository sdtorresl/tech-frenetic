import 'dart:async';

import 'package:techfrenetic/app/core/errors.dart';

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

  static final validateLoginPassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 8) {
        sink.add(password);
      } else {
        sink.addError(
          'La contraseña debe tener 8 carecteres',
        );
      }
    },
  );

  static final validateSignInPassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 8 &&
          password.contains(RegExp(r'[A-Z]')) &&
          password.contains(RegExp(r'[a-z]')) &&
          RegExp(r'\d').hasMatch(password)) {
        sink.add(password);
      } else if (password.length < 8) {
        sink.addError(
          'La contraseña debe tener 8 carecteres',
        );
      } else if (RegExp(r'\d').hasMatch(password) == false) {
        sink.addError(
          'La contraseña debe tener un numero',
        );
      } else if (password.contains(RegExp(r'[A-Z]')) == false) {
        sink.addError(
          'Debe tener minimo una mayuscula',
        );
      } else if (password.contains(RegExp(r'[a-z]')) == false) {
        sink.addError(
          'Debe tener minimo una minuscula',
        );
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
        sink.addError(ErrorType.fieldRequired);
      }
    },
  );

  static final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      RegExp regex = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
      if (regex.hasMatch(data)) {
        sink.add(data);
      } else {
        sink.addError(ErrorType.phoneInvalid);
      }
    },
  );

  static final validateProfession =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isNotEmpty) {
        sink.add(name);
      } else {
        sink.addError(
          'Ingresa una profesión',
        );
      }
    },
  );

  static final validateDate =
      StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (date, sink) {
      if (date != DateTime.now()) {
        sink.add(date);
      } else {
        sink.addError(ErrorType.dateRequired);
      }
    },
  );

  static final validateDateMeetups =
      StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (date, sink) {
      if (!date.isBefore(DateTime.now())) {
        sink.add(date);
      } else {
        sink.addError(ErrorType.futureDateRequired);
      }
    },
  );

  static final validateFieldRequired =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (field, sink) {
      if (field.isNotEmpty) {
        sink.add(field);
      } else {
        sink.addError(ErrorType.fieldRequired);
      }
    },
  );

  static final validateUrl = StreamTransformer<String, String>.fromHandlers(
    handleData: (url, sink) {
      String pattern =
          r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
      RegExp regExp = RegExp(pattern);

      if (regExp.hasMatch(url)) {
        sink.add(url);
      } else {
        if (url.isNotEmpty) {
          sink.addError(ErrorType.invalidUrl);
        } else {
          sink.add(url);
        }
      }
    },
  );

  static final validatePasswordCheckWrong =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (passwordCheck, sink) {
      sink.add(passwordCheck);
      //sink.addError("Las contraseñas no coinciden");
    },
  );

  final validatePasswordCheck = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      password.length > 8
          ? sink.add(password)
          : sink.addError("La contraseña debe tener más de 8 caracteres");
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

  static final validateConfirmPass = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (passwordValid, sink) {
      if (passwordValid) {
        sink.add(passwordValid);
      } else {
        sink.addError(
          'Las contraseñas no coinciden',
        );
      }
    },
  );

  static final validateCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (code, sink) {
      if (code.toString().length >= 6) {
        sink.add(code);
      } else {
        sink.addError(ErrorType.fieldRequired);
      }
    },
  );

  // static final validateConfirmPasword =
  //     StreamTransformer<List<String>, String>.fromHandlers(
  //   handleData: (password, sink) {
  //     if (password[0] == password[1]) {
  //       sink.add(password[1]);
  //     } else {
  //       sink.addError(
  //         'Las contraseñas no conciden',
  //       );
  //     }
  //   },
  // );
}
