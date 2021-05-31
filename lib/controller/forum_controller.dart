import 'package:floradb/model/forum/category.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class ForumController extends GetxController {
  DatabaseService _databaseService = Get.find();
  final forumCategoriesLD = <ForumCategory>[].obs;

  @override
  void onInit() {
    forumCategoriesLD.bindStream(streamForumCategories());
    super.onInit();
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

  dynamic streamForumThread(String id) {
    return _databaseService.firestore
        .collection('forum_thread')
        .where('categoryid', isEqualTo: id)
        .snapshots();
  }
}
