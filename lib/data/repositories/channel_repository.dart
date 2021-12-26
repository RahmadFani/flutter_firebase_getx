import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_starterpack/data/models/channel/channel.dart';
import 'package:get_storage/get_storage.dart' as get_storage;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChannelRepository {
  final FirebaseFirestore _firebaseFirestore;
  ChannelRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final box = get_storage.GetStorage();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<Channel>> getUserChannel({required List<String> list}) async {
    final channelCollection = _firebaseFirestore.collection('channels');
    final query = await channelCollection
        .where(FieldPath.documentId, whereIn: list)
        .get();
    final docs = query.docChanges;

    return docs.map((e) => e.doc.toChannel).toList();
  }

  Future<void> createChannel({
    required String name,
    required String type,
    File? image,
  }) async {
    try {
      String userId = box.read('user_id');

      DocumentReference channels =
          await _firebaseFirestore.collection('channels').add({
        'name': name,
        'type': type,
      });

      DocumentReference user =
          _firebaseFirestore.collection('users').doc(userId);

      channels.collection('roles').doc('super-admin').set({
        'name': 'Super Admin',
        'can': [0]
      });

      channels.collection('members').doc(userId).set({
        'joining_at': FieldValue.serverTimestamp(),
        'roles': FieldValue.arrayUnion(['super-admin'])
      });

      user.update(
        {
          'channels': FieldValue.arrayUnion([channels.id])
        },
      );

      if (image != null) {
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/channels/${channels.id}/image.png')
            .putFile(image);
        channels.update({'image': 'uploads/channels/${channels.id}/image.png'});
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

extension on DocumentSnapshot {
  Map<String, dynamic> get json {
    return data() as Map<String, dynamic>;
  }

  Channel get toChannel {
    return Channel(
        id: id, name: json['name'], type: json['type'], image: json['image']);
  }
}
