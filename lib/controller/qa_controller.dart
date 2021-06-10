import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floradb/model/qa/answer.dart';
import 'package:floradb/model/qa/question.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class QAController extends GetxController {
  DatabaseService _databaseService = Get.find();

  String _generateFileName() {
    DateTime dateTime = DateTime.now();
    String fileName = dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString() +
        dateTime.hour.toString() +
        dateTime.minute.toString() +
        dateTime.second.toString() +
        dateTime.millisecond.toString() +
        dateTime.microsecond.toString();
    return fileName;
  }

  Future<File?> attachImage() async {
    final picker = ImagePicker();
    PickedFile? image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 30);
      if (image != null) {
        var file = File(image.path);
        return file;
      }
    }
  }

  dynamic streamQuestions() {
    return _databaseService.firestore
        .collection('question')
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  Stream<Question> streamQuestion(String id) {
    return _databaseService.firestore
        .collection('question')
        .doc(id)
        .snapshots()
        .map((event) => Question.fromSnapshot(event));
  }

  Future<void> addQuestion(Question question) {
    return _databaseService.firestore
        .collection('question')
        .add(question.toJson())
        .then((value) {
      _databaseService.firestore
          .collection('question')
          .doc(value.id)
          .update({"id": value.id});
    });
  }

  Future<void> addQuestionWithAttachedImage(
      Question question, imageFilePath) async {
    Reference reference = _databaseService.storage
        .ref()
        .child('question_images/${_generateFileName()}');

    UploadTask uploadTask = reference.putFile(File(imageFilePath));

    uploadTask.whenComplete(() async {
      String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      question.attachedImage = downloadUrl;
      addQuestion(question);
    });
  }

  Stream<List<Answer>> streamAnswers(String id) {
    return _databaseService.firestore
        .collection('answers')
        .where('questionid', isEqualTo: id)
        .orderBy('created_on')
        .snapshots()
        .map((event) {
      List<Answer> answers = [];
      event.docs.forEach((element) {
        answers.add(Answer.fromSnapshot(element));
      });
      return answers;
    });
  }

  Future<void> addAnswer(Answer answer, String questionID) {
    return _databaseService.firestore
        .collection('answers')
        .add(answer.toJSON())
        .then((value) {
      _databaseService.firestore
          .collection('question')
          .doc(questionID)
          .update({"replies": FieldValue.increment(1)});
    });
  }
}
