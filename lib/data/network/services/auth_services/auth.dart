import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/data/network/requests.dart';
import 'package:online_shopping/model/user.dart';

abstract interface class AuthenticationServices {
  Future<String> signUp(AuthenticationRequest authenticationRequest);

  Future<String> signIn(AuthenticationRequest authenticationRequest);

  Future<UserCredential> signInWithGoogle();

  Future<void> storeUser(StoreUserRequest storeUserRequest);

  Future<void> forgotPassword({required String email});

  Future<UserModel> getUser({
    required String firebaseUserId,
    required String collectionName,
  });
}

final class AuthenticationServicesImplement implements AuthenticationServices {
  @override
  Future<String> signIn(AuthenticationRequest authenticationRequest) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authenticationRequest.email,
        password: authenticationRequest.password);
    return user.user!.uid;
  }

  @override
  Future<String> signUp(AuthenticationRequest authenticationRequest) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: authenticationRequest.email,
      password: authenticationRequest.password,
    );
    return user.user!.uid;
  }

  @override
  Future<void> storeUser(StoreUserRequest storeUserRequest) async {
    final docItem = FirebaseFirestore.instance
        .collection("users")
        .doc(storeUserRequest.uId);
    _JsonMap jsonUser = <String, dynamic>{
      'name': storeUserRequest.name,
      'email': storeUserRequest.email,
      'image': storeUserRequest.image
    };
    await docItem.set(jsonUser);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
// Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

// Obtain the auth details from the Google sign-in
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

// Create a new credential using the Google tokens
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

// Sign in to Firebase using the Google credentials
    return await auth.signInWithCredential(credential);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel> getUser(
      {required String firebaseUserId, required String collectionName}) async {
    final getOrdersJson = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .get();
    final data = getOrdersJson.data();
    final UserModel user = UserModel.fromMap(data!);
    return user;
  }
}

typedef _JsonMap = Map<String, dynamic>;
