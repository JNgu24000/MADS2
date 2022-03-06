import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Map<String, User> userMap = <String, User>{};

  final StreamController<Map<String, User>> _usersController =
      StreamController<Map<String, User>>();
  final StreamController<Map<String, User>> _messageController =
      StreamController<Map<String, User>>();

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('users').snapshots().listen(_messageUpdated);
  }

  Stream<Map<String, User>> get users => _usersController.stream;
  Stream<Map<String, User>> get messages => _messageController.stream;

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _messageUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getMessageFromSnapshot(snapshot);
    _messageController.add(users);
  }

  Map<String, User> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      User user = User.fromJson(element.id, element.data());
      userMap[user.id] = user;
    }

    return userMap;
  }

  Map<String, User> _getMessageFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      User message = User.fromJson(element.id, element.data());
      userMap[message.id] = message;
    }

    return userMap;
  }
}
