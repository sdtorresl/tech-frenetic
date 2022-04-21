import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techfrenetic/app/models/contact_model.dart';
import 'package:techfrenetic/app/providers/contact_provider.dart';
import '../../common/validators.dart';

class ContactUsController extends Disposable {
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _cellphoneController = BehaviorSubject<String>();
  final _subjectController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _termsController = BehaviorSubject<bool>();

  Stream<String> get nameStream =>
      _nameController.stream.transform(Validators.validateName);

  Stream<String> get emailStream =>
      _emailController.stream.transform(Validators.validateEmail);

  Stream<String> get cellphoneStream =>
      _cellphoneController.stream.transform(Validators.validateName);

  Stream<String> get subjectStream =>
      _subjectController.stream.transform(Validators.validateName);

  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(Validators.validateName);

  Stream<bool> get termsStream =>
      _termsController.stream.transform(Validators.validateTerms);

  Stream<bool> get formValidStream => Rx.combineLatest4(nameStream, emailStream,
      descriptionStream, termsStream, (e, p, c, a) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _cellphoneController.sink.add;
  Function(String) get changeSubject => _subjectController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(bool) get changeTerms => _termsController.sink.add;

  String get name => _nameController.value;
  String get email => _emailController.value;
  String get phone => _cellphoneController.value;
  String get subject => _subjectController.valueOrNull ?? '';
  String get description => _descriptionController.value;
  bool get terms => _termsController.value;

  Future<bool> contactUs() async {
    ContactModel contactData = ContactModel(
      name: name,
      email: email,
      phone: phone,
      message: description,
      subject: subject,
    );

    debugPrint(contactData.toString());

    ContactProvider contactProvider = ContactProvider();
    return contactProvider.sendContact(contactData);
  }

  @override
  void dispose() {
    _nameController.close();
    _emailController.close();
    _cellphoneController.close();
    _subjectController.close();
    _descriptionController.close();
    _termsController.close();
  }
}
