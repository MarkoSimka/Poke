#   FLUTTER CHAT APP "POKE"

This is a Flutter-based chat application that leverages Firebase for authentication and database services. This README file provides an overview of the project, instructions for setting up Firebase, and a brief description of the app's features.

##  Project Description

"Poke" is a versatile chat application built using the Flutter framework. It incorporates Firebase for user authentication and real-time database services, making it a robust and scalable solution for creating chat applications.

## Features

Firebase Integration: This app utilizes Firebase services for authentication and real-time database functionality. 

To add Firebase to your Flutter project, run the following command:

    flutter pub add firebase_core

Additional Firebase plugins used:

    firebase_auth for user authentication.

    cloud_firestore for real-time database.

## Custom UI Elements: 

The app features custom UI elements, such as a Group Card widget and chat box messages, to provide a unique and engaging user experience.

Mobile Design Patterns: "Poke" incorporates six effective mobile design patterns, enhancing the overall user interface and experience:

### Tab Bar:

Organize content using a tab-based navigation system.

### List View:

Display chat messages and group lists efficiently.

### Cards:

Utilize card-based UI elements for a modern look.

### Splash Screen:

Create an attractive and informative splash screen.

### Floating Action Button (FAB):

Implement FAB for quick actions.

### State Persistence: 

The app remembers the state of chat groups, user details, and chat messages, providing a seamless experience even after app restarts.

Reference: [Mobile Desing Paterns](https://www.designrush.com/best-designs/apps/trends/mobile-design-patterns)

##  Mobile Sensors:

### Location Sensor: 

Access the user's current location for location-based features.

### Gyroscope Sensor: 

Utilize the gyroscope sensor to detect device orientation (landscape or portrait mode).


##  Getting Started

To get started with this project, follow these steps:

Clone the repository:

    git clone https://github.com/MarkoSimka/Poke.git //https

    git clone git@github.com:MarkoSimka/Poke.git //ssh

##  Set up Firebase:

Create a Firebase project on the Firebase Console.

Add your Firebase configuration to the google-services.json file (for Android) and GoogleService-Info.plist file (for iOS) as per Firebase documentation.

Install the Firebase plugins by running the following commands:

    flutter pub get

Configure Firebase authentication and database services according to your project requirements.

##  Install Flutter:

If you haven't already, [install Flutter]( https://docs.flutter.dev/get-started/install ).

Run the app:

    flutter run

Dependencies

The app relies on several Flutter packages to enhance its functionality and user interface:

    1. firebase_core
    2. firebase_auth
    3. cloud_firestore

Make sure to include these packages in your pubspec.yaml file.

##  Contribution

Contributions to this project are welcome. Feel free to open issues or pull requests to suggest improvements or report bugs.

Happy coding!
