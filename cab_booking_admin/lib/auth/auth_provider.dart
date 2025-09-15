import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// FirebaseAuth instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Auth state stream
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

/// Login with email & password
final loginProvider = FutureProvider.family<User, Map<String, String>>((
  ref,
  creds,
) async {
  final auth = ref.watch(firebaseAuthProvider);
  final userCredential = await auth.signInWithEmailAndPassword(
    email: creds['email']!,
    password: creds['password']!,
  );
  return userCredential.user!;
});

/// Logout
final logoutProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    await ref.read(firebaseAuthProvider).signOut();
  };
});
