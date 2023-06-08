import '../models/user_model.dart';

String template(
    {User? user,
    required String title,
    required String body,
    String? scripts}) {
  return """
  <html>
<head>
    <title>${title}</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/fontawesome.min.js"></script>
    <link rel='stylesheet' href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin-top: 0;
        }

        .post-title {
            font-size: 1.5em;
            color: #5f99cf;
        }
        .post-header {
          display: flex
        }
        .post-body {
          padding: 20px;background: lightgray;
        }
        .username {
            color: #888;
        }
        .username a {
            color: #888;
        }
        .upvotes {
            color: #888;
        }
        .comment-text {
            margin-bottom: 10px;
        }
        .nested {
            margin-left: 20px;
        }
        .toggle {
            color: #888;
            cursor: pointer;
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
        
        .comment {
          display: flex;
        }
    </style>
</head>
<body>${body}
</body>
</html>""";
}
