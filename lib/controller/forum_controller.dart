import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floradb/model/forum/category.dart';
import 'package:floradb/model/forum/reply.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ForumController extends GetxController {
  DatabaseService _databaseService = Get.find();
  final forumCategoriesLD = <ForumCategory>[].obs;

  @override
  void onInit() {
    forumCategoriesLD.bindStream(streamForumCategories());
    super.onInit();
  }

  String _generateFileName() {
    DateTime dateTime = DateTime.now();
    String fileName = 'image_' +
        dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString() +
        dateTime.hour.toString() +
        dateTime.minute.toString() +
        dateTime.second.toString() +
        dateTime.millisecond.toString() +
        dateTime.microsecond.toString();
    return fileName;
  }

  Stream<List<ForumCategory>> streamForumCategories() {
    return _databaseService.firestore
        .collection('forum_category')
        .snapshots()
        .map((snapshot) {
      List<ForumCategory> categories = [];
      snapshot.docs.forEach((element) {
        categories.add(ForumCategory.fromSnapshot(element));
      });
      return categories;
    });
  }

  dynamic streamNewestThreads() {
    return _databaseService.firestore
        .collection('forum_thread')
        .limit(5)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  dynamic streamForumThread(String id) {
    return _databaseService.firestore
        .collection('forum_thread')
        .where('categoryid', isEqualTo: id)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  dynamic streamThreadReplies(String id) {
    return _databaseService.firestore
        .collection('thread_reply')
        .where('threadid', isEqualTo: id)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  Future<File?> attachImage() async {
    final picker = ImagePicker();
    PickedFile? image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await picker.getImage(source: ImageSource.gallery);
      if (image != null) {
        var file = File(image.path);
        return file;
      }
    }
  }

  Future<void> addReply(ThreadReply reply) {
    return _databaseService.firestore
        .collection('thread_reply')
        .add(reply.toJson())
        .then((value) {
      _databaseService.firestore
          .collection('forum_thread')
          .doc(reply.threadID)
          .update({"replies": FieldValue.increment(1)});
    });
  }

  Future<void> addReplyWithAttachedImage(
      ThreadReply reply, String imagePath) async {
    Reference reference = _databaseService.storage
        .ref()
        .child('thread_reply_images/${_generateFileName()}');

    UploadTask uploadTask = reference.putFile(File(imagePath));

    uploadTask.whenComplete(() async {
      String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      reply.attachedImage = downloadUrl;
      addReply(reply);
    });
  }

  Future<void> addThread(ForumThread thread) {
    return _databaseService.firestore
        .collection('forum_thread')
        .add(thread.toJson())
        .then((value) {
      _databaseService.firestore
          .collection('forum_thread')
          .doc(value.id)
          .update({"id": value.id});
      _databaseService.firestore
          .collection('forum_category')
          .doc(thread.categoryID)
          .update({
        "threadids": FieldValue.arrayUnion([value.id])
      });
    });
  }

  Future<void> addThreadWithAttachedImage(
      ForumThread thread, String imagePath) async {
    Reference reference = _databaseService.storage
        .ref()
        .child('forum_thread_images/${_generateFileName()}');

    UploadTask uploadTask = reference.putFile(File(imagePath));

    uploadTask.whenComplete(() async {
      String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      thread.attachedImage = downloadUrl;
      addThread(thread);
    });
  }
}
