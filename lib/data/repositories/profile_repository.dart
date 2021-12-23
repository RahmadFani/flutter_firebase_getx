import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as get_storage;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final box = get_storage.GetStorage();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Stream<Profile> get streamUserProfile {
    String userId = box.read('user_id');
    return _firebaseFirestore.collection('users').doc(userId).snapshots().map(
        (snapshot) =>
            snapshot.exists ? snapshot.toProfile : const Profile.empty());
  }

  Future<Profile> get getUserProfile async {
    try {
      String userId = box.read('user_id');
      CollectionReference user = _firebaseFirestore.collection('users');
      DocumentSnapshot snapshot = await user.doc(userId).get();
      return snapshot.exists ? snapshot.toProfile : const Profile.empty();
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  Future<void> saveUserProfile({required String nickname, File? avatar}) async {
    try {
      String userId = box.read('user_id');
      DocumentReference user =
          _firebaseFirestore.collection('users').doc(userId);

      user.set({"nickname": nickname});

      if (avatar != null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/avatars/$userId.png';
        await Directory('${appDocDir.path}/avatars').create(recursive: true);
        File file2 = File(filePath);
        file2.writeAsBytesSync(avatar.readAsBytesSync());
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/avatar/$userId.png')
            .putFile(avatar);

        user.set(
            {"avatar": 'uploads/avatar/$userId.png'}, SetOptions(merge: true));
      }
    } catch (e) {
      Get.log(e.toString());
      throw 'a';
    }
  }
}

extension on DocumentSnapshot {
  Map<String, dynamic> get json {
    return data() as Map<String, dynamic>;
  }

  Profile get toProfile {
    return Profile(
        id: id,
        nickname: json['nickname'],
        channels: json['channels'] ?? [],
        avatar: json['avatar']);
  }
}
