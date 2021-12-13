import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart';
import 'package:get_storage/get_storage.dart' as get_storage;

class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final box = get_storage.GetStorage();

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
}

extension on DocumentSnapshot {
  Map<String, dynamic> get json {
    return data() as Map<String, dynamic>;
  }

  Profile get toProfile {
    return Profile(id: id, name: json['name'], channels: json['channels']);
  }
}
