import 'package:markdown/markdown.dart';
import 'package:quokki/models/notification_model.dart';
import 'package:quokki/views/top_bar_view.dart';

import '../models/user_model.dart';

String userNotificationsView(User user) {
  final html = """
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #DAE0E6;
        }

        .header {
            background-color: #FF4500;
            color: white;
            padding: 10px 20px;
            text-align: left;
        }

        .content {
            padding: 20px;
        }

        .notification {
            background-color: white;
            margin-bottom: 10px;
            padding: 20px;
            border-radius: 5px;
        }

        .notification:hover {
            background-color: #f6f6f6;
        }

        a {
            color: #FF4500;
            text-decoration: none;
        }

        a:hover {
            color: #FF4500;
            text-decoration: underline;
        }
    </style>
</head>

<body>
    ${topBar(user: user, joey: null)}
    <div class="header">
        <h1>Notifications</h1>
    </div>

    <div>
        ${user.notifications.reversed.map((e) => commentItemView(e))}
    </div>
</body>

</html>
""";

  return html;
}

String commentItemView(Notification notification) {
  return """"
          <div class="notification">
            <p><b>${notification.author}</b> replied:</p>
            <p>${markdownToHtml(notification.body)}</p>
            <a href="${notification.notificationUrl}">View context</a>
        </div>
  """;
}
