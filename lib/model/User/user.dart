class Users {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  Users({required this.id, required this.firstName, required this.lastName, required this.email});

  Users.fromData(Map<String,dynamic> data)
    : id = data['id'],
      firstName = data['firstName'],
      lastName = data['lastName'],
      email = data['email'];

  Map<String,dynamic> toJson(){
    return{
      'id' : id,
      'firstName' : firstName,
      'lastName' : lastName,
      'email' : email,
    };
  }
}