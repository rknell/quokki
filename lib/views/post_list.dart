import 'package:calendar_time/calendar_time.dart';
import 'package:quokki/models/joey_model.dart';
import 'package:quokki/views/top_bar_view.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

/// Returns a HTML rendering of the post list view.
/// This is the current posts in a joey
///
String postListView(Joey joey, List<Post> posts, {User? user}) {
  return """
  <html>
    <head>
      <title>${joey.displayName}</title>
          <style>
         body {
            font-family: Arial, sans-serif;
            margin: 0;
        }
        
        .top-bar {
          background-color: black;
          padding: 5px;
        }
        
        .top-bar a {
          color: white;
        }

        .header {
            background-color: #0079D3;
            color: white;
            padding: 10px 0;
            margin-bottom: 20px;
            text-align: center;
        }

        .reddit-post {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            display: flex;
        }

        .reddit-post-title {
            font-size: 20px;
            color: #0079D3;
        }

        .reddit-post-details {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
        }

        .reddit-post-content {
            margin-left: 25px;
            font-size: 16px;
        }

        .vote-buttons {
            margin-right: 10px;
        }

        .vote-buttons i {
            display: block;
            width: 20px;
            cursor: pointer;
        }

        .vote-count {
            text-align: center;
            font-size: 20px;
            margin-bottom: 10px;
        }
        
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/fontawesome.min.js"></script>
    <link rel='stylesheet' href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    </head>
    <body>
    <div>
      ${topBar(user: user, joey: joey.idName)}
    </div>
    <div class='header'>
      <h1>${joey.displayName}</h1>
    </div>
    
      <ul>
        ${posts.map((post) => postListItemView(post)).join()}
      </ul>
      <script>
        \$(".upvote-button").click(function() {
            var postId = \$(this).closest(".reddit-post").attr("id");
            var joey = \$(this).closest(".reddit-post").attr("joey");
            \$.ajax({
                url: '/j/'+ joey + '/comments/'+ postId +'/upvote',
                type: 'POST',
                data: JSON.stringify({ "postId": postId }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function(result) {
                    console.log(result);
                    alert('Upvoted!');
                },
                error: function(request,msg,error) {
                    console.log(msg);
                    alert('Error in upvoting');
                }
            });
        });

        \$(".downvote-button").click(function() {
            var postId = \$(this).closest(".reddit-post").attr("id");
            var joey = \$(this).closest(".reddit-post").attr("joey");
            \$.ajax({
                url: '/j/'+ joey + '/comments/'+ postId +'/downvote',
                type: 'POST',
                data: JSON.stringify({ "postId": postId }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function(result) {
                    console.log(result);
                    alert('Downvoted!');
                },
                error: function(request,msg,error) {
                    console.log(msg);
                    alert('Error in downvoting');
                }
            });
        });
    </script>
    </body>
  </html>
  """;
}

/// Return a html rendering of a post list item
String postListItemView(Post post) {
  return """
      <div class="reddit-post" id="${post.id.toHexString()}" joey="${post.joey}">
        <div class="vote-buttons">
            <i class="fa-solid fa-circle-up upvote-button"></i>
            <div class="vote-count">${post.score}</div>
            <i class="fa-solid fa-circle-down downvote-button"></i>
        </div>
        <div class='reddit-post-content'>
          <div class="reddit-post-title">
            <a href="${post.linkUrl}">${post.title}</a> 
            ${post.isCommentPost == false ? '(${Uri.parse(post.url!).host})' : ''}
          </div>
          <div class="reddit-post-details">submitted ${CalendarTime(post.timestamp).toHuman} by ${post.author} to <a href='/j/${post.joey}'>/j/${post.joey}</a> </div>
          <div class="reddit-post-content">${truncateWithEllipsis(200, post.body)}</div>
          <div class="reddit-post-details"><a href="/j/${post.joey}/comments/${post.id.toHexString()}">${post.commentCount} comments</a> share save hide report</div>
        </div>
    </div>
  """;
}

// String topBar(User? user, Joey joey) {
//   if (user == null) {
//     return """
//     <div class="top-bar">
//       <a href="/account/login">Login | Signup</a>
//     </div>
//     """;
//   } else {
//     return """
//     <div class="top-bar">
//       <a href='/'>Front Page</a>
//       <a href="/j/${joey.idName}/create">Create Post</a>
//       <a href="/j/create">Create Community</a>
//       <a href="/account/logout">Logout</a>
//       ${renderNotificationBell(user)}
//     </div>
//     """;
//   }
// }

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
