import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:quokki/views/create_joey.dart';
import 'package:quokki/views/create_post.dart';
import 'package:quokki/views/post_list.dart';

import '../models/joey_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/database.dart';

/// Joeys are the equivalent to subreddits
/// They are the main way to organize posts on quokki
///
class JoeyRoute {
  static Future get(HttpRequest req, HttpResponse res) async {
    final joeyName = (req.params['joey'] as String).toLowerCase();
    final joey = await db.joeys.findOne({'idName': joeyName});
    if (joey == null) {
      throw AlfredException(404, {'message': 'Joey not found'});
    }
    var joeyObj = Joey.fromJson(joey);

    final query = SelectorBuilder()
      ..sortBy('rank', descending: true)
      ..excludeFields(['upvotes', 'downvotes', 'comments']);
    if (joeyName != 'all') {
      query.match('joey', joeyName);
    }
    final posts = await db.posts.find(query).take(100).toList();

    var postsObj = posts.map((e) => Post.fromJson(e)).toList();
    final currentUser = await User.getCurrentUser(req);

    if (req.requestedUri.queryParameters['json'] == 'true') {
      return posts;
    } else {
      res.headers.contentType = ContentType.html;
      return postListView(joeyObj, postsObj, user: currentUser);
    }
  }

  static Future create(HttpRequest req, HttpResponse res) async {
    final body = await req.bodyAsJsonMap;
    final currentUser = await User.getCurrentUser(req);
    if (currentUser == null) {
      throw AlfredException(
          401, {'message': 'You must be logged in to create a joey'});
    }
    final existingJoey = await db.joeys.findOne({'idName': body['idName']});
    if (existingJoey != null) {
      throw AlfredException(400, {'message': 'Joey already exists'});
    }
    final newJoey = Joey.fromJson(body);
    newJoey.idName = newJoey.idName.toLowerCase();
    newJoey.mods.add(currentUser.username);
    await db.joeys.insertOne(newJoey.toJson());
    return newJoey.toJson();
  }

  /// Show the create joey view
  static Future createView(HttpRequest req, HttpResponse res) async {
    final currentUser = await User.getCurrentUser(req);
    if (currentUser == null) {
      throw AlfredException(
          401, {'message': 'You must be logged in to create a joey'});
    }
    res.headers.contentType = ContentType.html;
    return createJoeyView();
  }

  static Future createPost(HttpRequest req, HttpResponse res) async {
    final body = await req.bodyAsJsonMap;
    final currentUser = await User.getCurrentUser(req);
    if (currentUser == null) {
      throw AlfredException(
          401, {'message': 'You must be logged in to create a post'});
    }
    final joeyName = req.params['joey'];
    body['joey'] = joeyName;
    body['author'] = currentUser.username;
    final post = Post.fromJson(body);
    post.upvotes.add(currentUser.username);
    await post.save();
    return post.toJson();
  }

  static Future createPostViewRoute(HttpRequest req, HttpResponse res) async {
    final joeyName = req.params['joey'] as String;
    final output = await createPostView(joey: joeyName);
    res.headers.contentType = ContentType.html;
    return output;
  }
}
