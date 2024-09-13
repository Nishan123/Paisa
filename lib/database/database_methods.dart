import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paisa/views/screens/home_screen.dart';
import 'package:paisa/views/screens/login_screen.dart';

class DatabaseMethods {
  void _showTopSnackBar(String message, context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top +
            10, // Adjusts based on the status bar height
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) {
      overlayEntry.remove();
    });
  }

  Future<void> signUp(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((User) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        _showTopSnackBar("Account created successfully ", context);
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "weak-password":
          message = "Password is too weak";
          break;
        case "email-already-in-use":
          message = "Email is already in use";
          break;
        case "user-disabled":
          message = "User account has been disabled.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      _showTopSnackBar(message, context);
      debugPrint(e.code);
    } catch (e) {
      _showTopSnackBar("An error occurred: ${e.toString()}", context);
    }
  }

// For loggin in with email and password
  Future<void> loginWithEmail(String email, String password, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "invalid-email":
          message = "Invalid email! check again";
        case "invalid-credential":
          message = "Email or password didn't match";
        case "user-disabled":
          message = "User account has been disabled";
        default:
          message = "An unknown error occured. Plese try angain";
          break;
      }
      _showTopSnackBar(message, context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// For logging out
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut().then((user) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> usersBalance(String uid, Map<String, dynamic> balanceMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(balanceMap);
  }

  Future<void> addTransaction(String userId, String transactionId,
      Map<String, dynamic> transactionMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("transactions")
        .doc(transactionId)
        .set(transactionMap);
  }

  Stream<QuerySnapshot> getTransactions(String filter, String userId) {
    if (filter == "All") {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("transactions")
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("transactions")
          .where("transaction type", isEqualTo: filter)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> getBalance() {
    return FirebaseFirestore.instance.collection("transactions").snapshots();
  }

  Future<void> initializeUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's document
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Check if user data exists
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        // If not exists, initialize with default values
        await userDoc.set({
          'totalIncome': 0,
          'totalExpenses': 0,
          'availableBalance': 0,
        });
        print("User data initialized for the first time.");
      } else {
        print("User data already exists.");
      }
    } else {
      print("No user is signed in.");
    }
  }
}
