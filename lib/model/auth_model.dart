/*class Auth {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  // Add more properties as needed

  Auth({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    // Add more properties as needed
  });

  // Factory method to create an Auth instance from FirebaseUser
  factory Auth.fromFirebaseUser(User firebaseUser) {
    return Auth(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      photoURL: firebaseUser.photoURL ?? '',
      // Map more properties from the FirebaseUser as needed
    );
  }*/
