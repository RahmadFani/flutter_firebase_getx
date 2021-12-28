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

  ///
  /// [getUserChannel]
  ///
  /// Get all [User] channel from firestore
  ///
  Future<List<Channel>> getUserChannel({required List<String> list}) async {
    final channelCollection = _firebaseFirestore.collection('channels');

    /// [FieldPath.documentId] is Document ID from [channels] collection
    final query = await channelCollection
        .where(FieldPath.documentId, whereIn: list)
        .get();
    final docs = query.docChanges;

    return docs.map((e) => e.doc.toChannel).toList();
  }

  ///
  /// [getChannelMember]
  ///
  /// Get all member channel from firestore
  ///
  Future<void> getChannelMember() async {}

  ///
  /// [getChannelRoles]
  ///
  /// Get all roles channel from firestore
  ///
  Future<void> getChannelRoles() async {}

  ///
  /// [createChannel]
  ///
  /// Create channel firestore
  ///
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

      ///
      /// [FieldValue]
      ///
      /// serverTimestamp => this will automatic get Time now from server
      /// arrayUnion => will get FieldValue from Field that we choose and push data
      /// arrayUnion Example
      /// 'roles': FieldValue.arrayUnion(['super-admin'])
      /// Firestore will automatic get Values from Field [roles] and push data ['super-admin'] to Values
      /// Before
      /// Values => ['Member', 'Moderator']
      /// result
      /// Values => ['Member', 'Moderator', 'super-admin']
      ///
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

///
/// extension [DocumentSnapshot]
///
/// this extension convert data() [json] to model [Dart]
///
extension on DocumentSnapshot {
  Map<String, dynamic> get json {
    return data() as Map<String, dynamic>;
  }

  Channel get toChannel {
    return Channel(
        id: id, name: json['name'], type: json['type'], image: json['image']);
  }
}
