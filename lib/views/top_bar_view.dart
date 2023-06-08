import '../models/user_model.dart';

/// Renders a black bar that goes along the top of the page
/// this is used for navigation and user account stuff
///

String topBar({required User? user, required String? joey}) {
  final sb = StringBuffer("""
  <style>
        .top-bar {
          background-color: black;
          padding: 5px;
          display: flex;
          gap: 10px;
        }
        </style>
    """);
  sb.write("<div class='top-bar'>");
  sb.write("<a href='/'>Front Page</a>");
  if (user == null) {
    sb.write("<a href='/account/login'>Login | Signup</a>");
  }
  if (user != null) {
    if (joey != null) {
      sb.write('<a href="/j/${joey}/create">Create Post</a>');
    }
    sb.write("<a href='/j/create'>Create Community</a>");
  }
  if (user != null) {
    final unreadNotifications = user.unreadNotifications;
    if (unreadNotifications.isEmpty) {
      sb.write(
          '<a href="/account/notifications"><i class="fa-solid fa-bell" style="color: white"></i></a>');
    } else {
      sb.write(
          '<a href="/account/notifications"><i class="fa-solid fa-bell" style="color: red"></i></a>');
    }
    sb.write('<a href="/account/logout">Log out</a>');
  }
  sb.write("</div>");

  return sb.toString();
}
