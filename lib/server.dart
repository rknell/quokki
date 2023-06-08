import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:quokki/middleware.dart';
import 'package:quokki/routes/admin.dart';
import 'package:quokki/routes/cents.dart';
import 'package:quokki/routes/posts.dart';
import 'package:quokki/routes/users.dart';

/// quokki is a social media app similar to reddit that allows
/// communities to gather and post content. This is the main class
/// that runs the app.
///
/// All endpoints should return html or json.
///

class Server {
  final app = Alfred();

  Future<void> init() async {
    app.all('*', Middleware.parseJWTFromCookies);

    app.get('/status', (req, res) => res.json({'hello': 'world'}));
    app.get('/', (req, res) {
      res.redirect(Uri.parse('/j/all'));
    });
    app.get('/j/create', JoeyRoute.createView,
        middleware: [Middleware.isAuthenticated]);
    app.get('/j/:joey', JoeyRoute.get);
    app.get('/j/:joey/create', JoeyRoute.createPostViewRoute,
        middleware: [Middleware.isAuthenticated]);

    app.post('/j/:joey', JoeyRoute.createPost,
        middleware: [Middleware.isAuthenticated]);
    app.post('/j', JoeyRoute.create, middleware: [Middleware.isAuthenticated]);

    app.get('/j/:joey/comments/:postId', PostsRoutes.get);

    /// Add a comment to a post
    app.post('/j/:joey/comments/:postId', PostsRoutes.addComment,
        middleware: [Middleware.isAuthenticated]);

    // Upvote & downvote a post
    app.post('/j/:joey/comments/:postId/upvote', PostsRoutes.upvote,
        middleware: [Middleware.isAuthenticated]);
    app.post('/j/:joey/comments/:postId/downvote', PostsRoutes.downvote,
        middleware: [Middleware.isAuthenticated]);

    /// Post a comment reply
    app.post(
        '/j/:joey/comments/:postId/comment/:commentId', PostsRoutes.addComment,
        middleware: [Middleware.isAuthenticated]);

    // Upvote and downvote a post comment
    app.post('/j/:joey/comments/:postId/comment/:commentId/upvote',
        PostsRoutes.upvoteComment,
        middleware: [Middleware.isAuthenticated]);
    app.post('/j/:joey/comments/:postId/comment/:commentId/downvote',
        PostsRoutes.downvoteComment,
        middleware: [Middleware.isAuthenticated]);

    app.get('/r/:joey', JoeyRoute.get);
    app.get('/u/:username', UserRoutes.getUser);
    app.post('/account/login', UserRoutes.login);
    app.get('/account/login', UserRoutes.loginView);
    app.get('/account/logout', UserRoutes.logout);
    app.post('/account/create', UserRoutes.create);
    app.get('/account/current', UserRoutes.getCurrentUser,
        middleware: [Middleware.isAuthenticated]);

    /// Admin routes. Probably need to project these from spam or use some internal
    /// strategy to kick them off.
    app.get('/admin/rankPosts', AdminRoute.rankPosts,
        middleware: [Middleware.isAdmin]);

    app.printRoutes();
    app.listen(int.parse(Platform.environment['PORT'] ?? '3000'));
  }
}
