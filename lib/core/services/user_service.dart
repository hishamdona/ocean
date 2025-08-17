import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  Future<User> createUser(User user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).set(user.toJson());
      return user;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      
      if (!doc.exists) {
        throw Exception('User not found');
      }
      
      return User.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      await _firestore.collection(_collection).doc(user.id).update(user.toJson());
      return user;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<List<User>> searchUsers(String query, {int limit = 20}) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThan: query + 'z')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => User.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      final batch = _firestore.batch();
      
      // Add to current user's following
      batch.set(
        _firestore
            .collection(_collection)
            .doc(currentUserId)
            .collection('following')
            .doc(targetUserId),
        {'followedAt': FieldValue.serverTimestamp()},
      );
      
      // Add to target user's followers
      batch.set(
        _firestore
            .collection(_collection)
            .doc(targetUserId)
            .collection('followers')
            .doc(currentUserId),
        {'followedAt': FieldValue.serverTimestamp()},
      );
      
      // Update counts
      batch.update(
        _firestore.collection(_collection).doc(currentUserId),
        {'followingCount': FieldValue.increment(1)},
      );
      
      batch.update(
        _firestore.collection(_collection).doc(targetUserId),
        {'followersCount': FieldValue.increment(1)},
      );
      
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }

  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    try {
      final batch = _firestore.batch();
      
      // Remove from current user's following
      batch.delete(
        _firestore
            .collection(_collection)
            .doc(currentUserId)
            .collection('following')
            .doc(targetUserId),
      );
      
      // Remove from target user's followers
      batch.delete(
        _firestore
            .collection(_collection)
            .doc(targetUserId)
            .collection('followers')
            .doc(currentUserId),
      );
      
      // Update counts
      batch.update(
        _firestore.collection(_collection).doc(currentUserId),
        {'followingCount': FieldValue.increment(-1)},
      );
      
      batch.update(
        _firestore.collection(_collection).doc(targetUserId),
        {'followersCount': FieldValue.increment(-1)},
      );
      
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to unfollow user: $e');
    }
  }

  Future<bool> isFollowing(String currentUserId, String targetUserId) async {
    try {
      final doc = await _firestore
          .collection(_collection)
          .doc(currentUserId)
          .collection('following')
          .doc(targetUserId)
          .get();
      
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check follow status: $e');
    }
  }

  Stream<List<User>> getFollowers(String userId) {
    return _firestore
        .collection(_collection)
        .doc(userId)
        .collection('followers')
        .snapshots()
        .asyncMap((snapshot) async {
      final followerIds = snapshot.docs.map((doc) => doc.id).toList();
      
      if (followerIds.isEmpty) return <User>[];
      
      final users = await Future.wait(
        followerIds.map((id) => getUserById(id)),
      );
      
      return users;
    });
  }

  Stream<List<User>> getFollowing(String userId) {
    return _firestore
        .collection(_collection)
        .doc(userId)
        .collection('following')
        .snapshots()
        .asyncMap((snapshot) async {
      final followingIds = snapshot.docs.map((doc) => doc.id).toList();
      
      if (followingIds.isEmpty) return <User>[];
      
      final users = await Future.wait(
        followingIds.map((id) => getUserById(id)),
      );
      
      return users;
    });
  }
}