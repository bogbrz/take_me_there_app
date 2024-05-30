import 'package:hooks_riverpod/hooks_riverpod.dart';

class User {
  const User(
      {required this.name,
      required this.surname,
      required this.email,
      required this.profilePictureUrl,
      required this.isVerifed,
      required this.id});
  final String name;
  final String surname;
  final String email;
  final String profilePictureUrl;
  final String id;
  final bool isVerifed;

  String toString() {
    return "User{id: $id, name: $name, surname: $surname, email: $email, pictureUrl: $profilePictureUrl, isVerified: $isVerifed,}";
  }
}

class UserProfile extends Notifier<User> {

  
  @override
  User build() {
    return User(
        name: "Jan",
        surname: "kowalski",
        email: "jan@gmail.com",
        profilePictureUrl:
            "https://www.shutterstock.com/image-photo/profile-picture-smiling-young-african-260nw-1873784920.jpg",
        isVerifed: false,
        id: "1");
  }

  void edit({required String name}) {
    state = User(
        name: name,
        surname: state.surname,
        email: state.email,
        profilePictureUrl: state.profilePictureUrl,
        isVerifed: state.isVerifed,
        id: state.id);
  }
}
