class UserEntity{
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatar;
  final bool isOnline;
  final String lastActive;
  final String token;
  

  UserEntity({
    required this.id,
     required this.name, 
     required this.email,
     required this.password, 
     required this.avatar,
     required this.isOnline,
     required this.lastActive, 
     this.token = ''
  });
}

