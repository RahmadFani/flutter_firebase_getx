import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_starterpack/data/models/channel/channel.dart';
import 'package:get_storage/get_storage.dart' as get_storage;

class ChannelRepository {
  final FirebaseFirestore _firebaseFirestore;
  ChannelRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  final box = get_storage.GetStorage();

  Future<List<Channel>> getUserChannel({required List<String> list}) async {
    final channelCollection = _firebaseFirestore.collection('channels');
    final query = await channelCollection
        .where(FieldPath.documentId, arrayContainsAny: list)
        .get();
    final docs = query.docChanges;
    return docs.map((e) => e.doc.toChannel).toList();
  }

  Future<void> createChannel({
    required String name,
    required String type,
    File? image,
  }) async {}
}

extension on DocumentSnapshot {
  Map<String, dynamic> get json {
    return data() as Map<String, dynamic>;
  }

  Channel get toChannel {
    return Channel(
        id: id,
        name: json['name'],
        type: json['type'],
        roles: json['roles'] ?? []);
  }
}
