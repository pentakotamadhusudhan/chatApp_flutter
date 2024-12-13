class StaticUrl{
  static String baseUrl = "http://192.168.2.82:8000";
  static String webSocketUrl = "ws://192.168.2.82:8000/ws/";
  static String loginUrl = "$baseUrl"+"/chat/login";
  static String createUrl = "$baseUrl"+"/chat/user";
  static String getfriendsUrl = "$baseUrl"+"/chat/getfriends";
  static String findFriendsUrl = "$baseUrl"+"/chat/findfriends";
  static String userUpdateUrl = "$baseUrl"+"/chat/userupdate/";
}