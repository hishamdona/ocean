import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user_model.dart';

class UserService {
  static const String _usersKey = 'users_data';

  Future<User> createUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey) ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson));
      
      users[user.id] = user.toJson();
      await prefs.setString(_usersKey, json.encode(users));
      
      return user;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey) ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson));
      
      if (!users.containsKey(userId)) {
        throw Exception('User not found');
      }
      
      return User.fromJson(users[userId]);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey) ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson));
      
      users[user.id] = user.toJson();
      await prefs.setString(_usersKey, json.encode(users));
      
      return user;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey) ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson));
      
      users.remove(userId);
      await prefs.setString(_usersKey, json.encode(users));
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<List<User>> searchUsers(String query, {int limit = 20}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey) ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson));
      
      final userList = users.values
          .map((userData) => User.fromJson(userData))
          .where((user) => user.fullName.toLowerCase().contains(query.toLowerCase()))
          .take(limit)
          .toList();
      
      return userList;
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    try {
      // Simulate follow functionality with local storage
      final prefs = await SharedPreferences.getInstance();
      final followingKey = 'following_$currentUserId';
      final followersKey = 'followers_$targetUserId';
      
      final followingJson = prefs.getString(followingKey) ?? '[]';
      final followersJson = prefs.getString(followersKey) ?? '[]';
      
      final following = List<String>.from(json.decode(followingJson));
      final followers = List<String>.from(json.decode(followersJson));
      
      if (!following.contains(targetUserId)) {
        following.add(targetUserId);
        followers.add(currentUserId);
        
        await prefs.setString(followingKey, json.encode(following));
        await prefs.setString(followersKey, json.encode(followers));
      }
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }

  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingKey = 'following_$currentUserId';
      final followersKey = 'followers_$targetUserId';
      
      final followingJson = prefs.getString(followingKey) ?? '[]';
      final followersJson = prefs.getString(followersKey) ?? '[]';
      
      final following = List<String>.from(json.decode(followingJson));
      final followers = List<String>.from(json.decode(followersJson));
      
      following.remove(targetUserId);
      followers.remove(currentUserId);
      
      await prefs.setString(followingKey, json.encode(following));
      await prefs.setString(followersKey, json.encode(followers));
    } catch (e) {
      throw Exception('Failed to unfollow user: $e');
    }
  }

  Future<bool> isFollowing(String currentUserId, String targetUserId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followingKey = 'following_$currentUserId';
      final followingJson = prefs.getString(followingKey) ?? '[]';
      final following = List<String>.from(json.decode(followingJson));
      
      return following.contains(targetUserId);
    } catch (e) {
      throw Exception('Failed to check follow status: $e');
    }
  }
}