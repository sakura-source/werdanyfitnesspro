WerdanyFitnessPRO 🏋️‍♂️💪

Revolutionizing Personal Training and Fitness Management

Welcome to WerdanyFitnessPRO, the cutting-edge platform that's redefining the fitness industry. Our solution combines 

state-of-the-art technology with intuitive design to empower trainers and fitness enthusiasts alike.

WerdanyFitnessPRO Logo

Table of Contents                      Features                      Technologies Used                           
Project Goals                      Getting Started                      Project Structure
Installation                      Usage                      Contributing
License                      Contact                      Features

1. Personalized Training Programs 🎯
AI-powered customization based on user goals, fitness levels, and preferences
Daily workout and nutrition plans tailored for optimal results
Adaptive programming that evolves with user progress

2. Comprehensive Progress Tracking 📊
Visual dashboards for weight, reps, calories burned, and more
Weekly insights and comparisons to monitor progress
Long-term trend analysis and goal projection

3. Seamless Trainer-Client Interaction 🤝
Secure and intuitive chat interface for real-time communication
Video call integration for remote coaching sessions
Efficient session booking and management system

4. Engaging Fitness Challenges 🏆
Gamified challenges to boost motivation and engagement
Dynamic leaderboards for friendly competition
Customizable challenge creation for trainers

5. Smart AI Recommendations 🧠
AI-suggested exercises, meals, and recovery routines
Adaptable suggestions based on progress and feedback
Integration with wearable devices for enhanced personalization

6. Localized User Experience 🌍
Full support for the Kuwaiti dialect for a personal touch
Culturally sensitive content and interface customization
Multi-language support for global scalability

7. Body Stats Tracking 📈
Track body stats such as weight, muscle mass, and fat percentage
Visualize progress with charts and graphs
Easily add, edit, and delete body stats

8. Diet Plan Management 🍽️
Create and manage personalized diet plans
Track daily calorie intake and macronutrient distribution
Get AI-suggested meal plans based on goals and preferences

9. Progress Photos 📸
Capture and store progress photos
Add notes to each photo for detailed tracking
Compare photos side-by-side to see progress over time

10. Sponsor Management 🤝
Manage sponsor information including name, logo, and website
Easily add, edit, and delete sponsors
Display sponsor information on the app

11. Trainer Profiles 🏋️‍♂️
Create and manage trainer profiles
Track trainer-client interactions and schedules
Easily add, edit, and delete trainer profiles

12. User Management 👤
Manage user information including name, email, and password
Easily add, edit, and delete users
Track user progress and interactions

Technologies Used
Frontend

Flutter: Cross-platform development for iOS and Android

Tailwind CSS: Sleek and modern design (planned for web interface)

Dart: Primary programming language for Flutter development

Backend                      Firebase:                      Authentication
Realtime Database                      Cloud Functions                      Cloud Storage
Google Cloud AI: Advanced analytics and AI-driven insights

AI Integration

Google Generative AI SDK: For personalization and smart recommendations

Gemini AI: Advanced AI integration for predictive modeling

TensorFlow: Custom model training for fitness-specific applications

Other Tools

GitHub: Version control and collaborative development

Hugging Face: NLP for chat functionality and language customizations

Figma: UI/UX design and prototyping

Jira: Project management and issue tracking

Project Goals

Deliver an innovative, AI-driven fitness solution tailored for both personal trainers and clients

Integrate cutting-edge AI features for real-time customization and adaptive programming

Create an engaging, user-friendly experience with a focus on creativity and cultural sensitivity

Provide seamless cross-platform functionality with a consistent and intuitive UI/UX

Maintain a high-performance, scalable backend for fast and reliable data processing

Establish WerdanyFitnessPRO as the leading fitness management platform in the MENA region

Getting Started

(Instructions for setting up the development environment, including prerequisites and initial configuration)

Project Structure

lib

├── main.dart                                                             # Entry point of the app

├── screens/                                                              # All screens for the app

│   ├── home_screen.dart                                                  # Dashboard for trainers and clients

│   ├── profile_screen.dart                                               # User profile management

│   ├── workout_screen.dart                                               # Display and track workouts

│   ├── chat_screen.dart                                                  # Trainer-client communication

│   ├── progress_screen.dart                                              # Fitness progress tracking

│   ├── settings_screen.dart                                              # Customizable settings

│   ├── body_tracking_screen.dart                                         # Body stats tracking

│   ├── diet_plan_screen.dart                                             # Diet plan management

│   ├── progress_photos_screen.dart                                       # Progress photos

│   ├── sponsors_screen.dart                                              # Sponsor management

│   ├── trainer_dashboard_screen.dart                                     # Trainer profiles

│   ├── user_management_screen.dart                                       # User management

├── widgets/                                                              # Reusable UI components

│   ├── custom_button.dart                                                # Buttons with animations

│   ├── progress_card.dart                                                # Cards to display progress metrics

│   ├── body_stat_chart.dart                                              # Charts for body stats

│   ├── diet_card.dart                                                    # Cards for diet plans

│   ├── photo_comparison_widget.dart                                      # Widget for comparing progress photos

│   ├── sponsor_card.dart                                                 # Cards for sponsors

│   ├── trainer_card.dart                                                 # Cards for trainers

│   ├── user_card.dart                                                    # Cards for users

├── services/                                                             # Backend and API integrations

│   ├── firebase_service.dart                                             # Firebase integration

│   ├── ai_service.dart                                                   # AI integration

│   ├── body_stats_service.dart                                           # Body stats service

│   ├── diet_plan_service.dart                                            # Diet plan service

│   ├── progress_photos_service.dart                                      # Progress photos service

│   ├── sponsor_service.dart                                              # Sponsor service

│   ├── trainer_service.dart                                              # Trainer service

│   ├── user_service.dart                                                 # User service

├── models/                                                               # Data models

│   ├── user_model.dart                                                   # User data structure

│   ├── workout_model.dart                                                # Workout data structure

│   ├── body_stats_model.dart                                             # Body stats data structure

tests/                                                                    # Unit and integration tests

assets/                                                                   # Images, fonts, and other static assets

Installation

(Detailed steps for installing and setting up the project locally)

Usage
(Instructions on how to use the application, including examples and screenshots)

Contributing
We welcome contributions to WerdanyFitnessPRO! Please read our Contributing Guidelines for details on our code of conduct and the process for submitting pull requests.

License
This project is licensed under the MIT License.

Contact
For any inquiries or support, please contact us at:

Email: support@werdanyfitnesspro.com

Website: www.werdanyfitnesspro.com
Twitter: @WerdanyFitness
© 2025 WerdanyFitnessPRO. All rights reserved.

## Running Tests

To ensure the correctness of the project, we have implemented comprehensive unit tests and UI tests. Follow the instructions below to run the tests:

### Unit Tests

Unit tests are located in the `test/services` directory. To run the unit tests, use the following command:

```sh
flutter test test/services
```

### UI Tests

UI tests are located in the `test/screens` directory. To run the UI tests, use the following command:

```sh
flutter test test/screens
```

### CI/CD Pipeline

We have configured a CI/CD pipeline using GitHub Actions to automate testing and deployment. The pipeline is defined in the `.github/workflows/ci.yml` file. The pipeline includes the following steps:

1. Checkout code
2. Set up Flutter
3. Install dependencies
4. Run unit tests for services
5. Run UI tests for screens
6. Run lint
7. Deploy to Firebase

The pipeline is triggered on every push to the `main` branch and on every pull request to the `main` branch.

To view the status of the CI/CD pipeline, go to the [Actions](https://github.com/sakura-source/werdanyfitnesspro/actions) tab in the GitHub repository.

## Setting Up Firebase

To set up Firebase for this project, follow these steps:

1. **Create a Firebase project**: Go to the Firebase Console and create a new project. Follow the instructions to set up the project.

2. **Add Firebase to your Flutter app**: In the Firebase Console, add an Android and iOS app to your Firebase project. Follow the instructions to download the `google-services.json` file for Android and the `GoogleService-Info.plist` file for iOS.

3. **Configure Android**:
   - Place the `google-services.json` file in the `android/app` directory.
   - Add the following classpath to the `android/build.gradle` file:
     ```gradle
     dependencies {
         classpath 'com.google.gms:google-services:4.3.10'
     }
     ```
   - Apply the Google services plugin at the bottom of the `android/app/build.gradle` file:
     ```gradle
     apply plugin: 'com.google.gms.google-services'
     ```

4. **Configure iOS**:
   - Place the `GoogleService-Info.plist` file in the `ios/Runner` directory.
   - Open the `ios/Runner.xcworkspace` in Xcode.
   - Right-click on the `Runner` project in the Project Navigator and select "Add Files to 'Runner'".
   - Add the `GoogleService-Info.plist` file to the project and ensure it is added to all targets.

5. **Add Firebase dependencies**: Add the necessary Firebase dependencies to your `pubspec.yaml` file. For example:
   ```yaml
   dependencies:
     firebase_core: latest_version
     firebase_auth: latest_version
     cloud_firestore: latest_version
   ```

6. **Initialize Firebase in your Flutter app**: In your `lib/main.dart` file, initialize Firebase before running the app:
   ```dart
   import 'package:firebase_core/firebase_core.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

7. **Update CI/CD pipeline**: Ensure that the CI/CD pipeline in `.github/workflows/ci.yml` includes steps to deploy to Firebase. The `deploy` job in the file already includes a step to deploy to Firebase hosting:
   ```yaml
   deploy:
     name: Deploy to Firebase
     runs-on: ubuntu-latest
     needs: [test, lint]

     steps:
       - name: Checkout code
         uses: actions/checkout@v2

       - name: Set up Flutter
         uses: subosito/flutter-action@v2
         with:
           flutter-version: '2.2.3'

       - name: Install dependencies
         run: flutter pub get

       - name: Deploy to Firebase
         run: flutter build web && firebase deploy --only hosting
   ```
