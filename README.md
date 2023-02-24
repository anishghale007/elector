# elector
![flutter](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)

![mockup](https://user-images.githubusercontent.com/72159017/220967706-531ae1a2-4633-4622-a566-d2eddc0469d3.jpg)

<h3> "Vote anywhere, at any time" </h3> <br>
An Election electronic-voting (e-voting) mobile application built with Flutter.

# Table of Contents

1. [Description](#Description)
    * [What the user can do](#WhatTheUserCanDo)
    * [Admin Panel](#AdminPanel)
2. [Packages Used](#PackagesUsed)
3. [Install](#Install)
4. [Screenshots](#Install)
    * [Splash Screen](#SplashScreen)
    * [Login and Registration](#LoginAndRegistration)
    * [Voter ID Error Message](#ErrorMessage)
    * [Email Verification Page](#EmailVerification)
    * [Fingerprint Page](#FingerprintPage)
    * [Home Page](#HomePage)
    * [Election Vote Page](#ElectionVotePage)
    * [Election Stats Page](#ElectionStats)
    * [Provincial Election Vote Statistics Page](#ProvincialElection)
    * [Profile Page](#ProfilePage)
    * [Voting Instructions Page](#VotingInstructions)
    * [Election FPTP & PR Voting Page](#ElectionFPTP)
    * [Three-step Vote Verification Process Page](#ThreeStep)
    * [Election Vote History](#ElectionVoteHistory)
   

## Description   <a name="Description"></a> 

<div id="Description">
“Elector” is a mobile application that uses three steps of voting verification process as well as end to end data encryption. The primary goals of “elector” are to preserve election integrity, provide accessibility to both domestic and overseas citizens, produce accurate voting results, reduce the election cost, eliminate the use of paper ballots, thwart any illegal acts, and to raise the voter turnout. This project was developed using the Flutter framework, which is a software development kit used for developing multi-platform applications from a single codebase. The frontend was built with the Dart programming language, and the Firebase database was used as the backend. Because this is the first version of the app, there are numerous opportunities for improvements and new features.<br>
  <br>
<code>flutter_riverpod</code> and <code>GetX</code> was used for the state management. GetX was also used for navigation and getting dialog box. The project was built using the MVC pattern. The use of Flutter Framework makes the app available for both iOS and Android devices. Hence, the app was not designed for web and desktop version. The app is responsive only on mobile and tablet devices. <br>
  <br>
  Inorder to register in the system, the user must enter a voter ID that is registered in the DB and a voter ID that has not been used by another user. The registered Voter IDs in the DB are: 1001, 1002, 1003, 1004, and 1005. After entering the personal information, an email verification mail will be sent to the email account that the user has given. So, the user is required to give a genuine email account. After confirming their email, the user will have to enable fingerprint scan. Without enabling it, the user will not gain access to the main page or system. Bear in mind that this app will not work in a smartphone without a biometric technology. Only one biometric scan i.e. fingerpint scan, has been inegrated in the app with plans to integrate more in the future. <br>
  <br> 
  This app was created with the main goal of assisting the election process in Nepal. Currently, there are three types of election in Nepal: General election, Provincial election and Local election. This app only implements the General election and Local election. This app uses one single-member nation-wide constituency for Federal Election FPTP (First-Past-The-Post) voting method instead of the 165 single-member constituencies in the FPTP voting method as of now. It also uses one single-member provincial-wide constituencies for Provincial Election FPTP (First-Past-The-Post) voting instead of the 330 single-member constituencies in the FPTP voting method.
 
  </div>
  
### What the user can do   <a name="WhatTheUserCanDo"></a>
  <div id="WhatTheUserCanDo">
  
  
- Register using their email address and voter ID (must be registered in the DB and must not be used by another user). 
- Riew the ongoing and upcoming election.
- Change their profile picture and password.
- Vote in the election and view the live or post results of the election.
- View their voting history.
  </div>

  
### Admin Panel  <a name="AdminPanel"></a>
<div id="AdminPanel">
This app has an admin panel which was also made from Flutter Framework (Flutter Web). You can find it <a href="https://github.com/anishghale007/elector-admin-panel">here</a>
  </div>

## Packages Used  <a name="PackagesUsed"></a>

<div id="PackagesUsed">
  
  
* flutter_riverpod: ^1.0.4
* get: ^4.6.5
* font_awesome_flutter: ^10.1.0
* shared_preferences: ^2.0.15
* dotted_border: ^2.0.0+2
* image_picker: ^0.8.5+3
* lottie: ^1.3.0
* carousel_slider: ^4.1.1
* firebase_core: ^1.24.0
* cloud_firestore: ^3.5.1
* firebase_auth: ^3.11.2
* firebase_storage: ^10.3.11
* local_auth: ^2.1.2
* flutter_secure_storage: ^6.0.0
* intl: ^0.17.0
* charts_flutter: ^0.12.0
  </div>


## Install    <a name="Install"></a>
<div id="Install">
  <code>git clone https://github.com/anishghale007/elector
flutter pub get
</code>
  </div>
  
 
## Screenshots  <a name="Screenshots"></a>
  
### Splash Screen
<div id="SplashScreen">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221242148-093b80f2-0009-4bbc-acfa-f2d68a2f3d6f.jpg" width="300" height="600" />
</p>
  </div>
  <br>
  
### Login and Registration 
<div id="LoginAndRegistration">
         <br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221237679-c64cd30e-ffc4-426c-a5df-dfa2aa7d0f30.jpg" width="300" height="600" />
  <img src="https://user-images.githubusercontent.com/72159017/221237629-e2c3f78b-a6ff-4ba9-baf2-15ba2deb28f8.jpg" width="300" height="600" /> 
  <img src="https://user-images.githubusercontent.com/72159017/221237653-c48826d8-4a19-4135-b46b-cac7fc3cf336.jpg" width="300" height="600" />
</p>
                                                                                                                                           </div>
                                                                                                                                           <br>

### Voter ID Error Message
<div id="ErrorMessage">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221241107-fbb3d54a-a521-43c1-904c-b208bba9b321.jpg" width="300" height="600" />
  <img src="https://user-images.githubusercontent.com/72159017/221241123-31426882-deb5-44f4-945e-22dec30d2269.jpg" width="300" height="600" /> 
</p>
  </div>
   <br>

### Email Verification Page
<div id="EmailVerification">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221242747-e280ca46-7348-43ad-bbe0-07a0ae44f0ca.png" width="300" height="600" />
</p>
 </div>
  <br>
 
### Fingerprint Page
<div id="FingerprintPage">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221243073-9eb3e0a5-4245-4953-87dc-617862a19881.png" width="300" height="600" />
</p>
  </div>
   <br>

### Home Page
<div id="HomePage">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221243764-0c75c5ea-b43c-4c23-8681-0c8ef3a7adf5.jpg" width="300" height="600" />
</p>
  </div>
   <br>

### Election Vote Page
<div id="ElectionVotePage">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221244828-c7abff2d-33cf-43a1-b0aa-d2cdddfb6a7d.jpg" width="300" height="600" />
   <img src="https://user-images.githubusercontent.com/72159017/221244846-2f9d8c59-8432-4a82-8b0b-cfa35ec09712.jpg" width="300" height="600" />
</p>
  </div>
   <br>

### Election Stats Page
<div id="ElectionStats">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221245527-a2f5a6b3-408f-426c-9df5-486e73fb95e1.jpg" width="300" height="600" />
  <img src="https://user-images.githubusercontent.com/72159017/221245572-f2f3ec03-31b1-4caf-9ca0-2ebf0b2fcc62.jpg" width="300" height="600" /> 
  <img src="https://user-images.githubusercontent.com/72159017/221245627-d621966e-0d7b-4f5f-8b47-f97f027ff3f7.jpg" width="300" height="600" />
</p>
  </div>
   <br>

### Provincial Election Vote Statistics Page
<div id="ProvincialElection">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221245928-577fff6a-78f0-4947-a68b-90d1009d7195.jpg" width="300" height="600" />
</p>
  </div>
   <br>

### Profile Page
<div id="ProfilePage">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221246049-2dd8a1d3-f27f-444e-a2ea-f1f5b607f707.jpg" width="300" height="600" />
</p>
   </div>
   <br>

### Voting Instructions Page
<div id="VotingInstructions">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221246173-aa683dcb-e1d4-44dc-977b-b0242e4896c8.jpg" width="300" height="600" />
  <img src="https://user-images.githubusercontent.com/72159017/221246179-506d9b54-ed82-435c-ae54-3b482d182fdd.jpg" width="300" height="600" /> 
  <img src="https://user-images.githubusercontent.com/72159017/221246188-e5062536-dcde-4950-aa37-f8d6529acfca.jpg" width="300" height="600" />
</p>
  </div>
   <br>

### Election FPTP & PR Voting Page
<div id="ElectionFPTP">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221246526-74194a45-df31-4128-ba9c-cf54f6c23b86.jpg" width="300" height="600" />
   <img src="https://user-images.githubusercontent.com/72159017/221246564-46906a2b-758e-4c42-8aa3-ffa665b9f9f2.jpg" width="300" height="600" />
</p>
  </div>
   <br>



### Three-step Vote Verification Process Page
<div id="ThreeStep">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221246683-64d628ec-ac9f-4240-a6b5-0224e652f6e0.jpg" height="600" />
  <img src="https://user-images.githubusercontent.com/72159017/221246697-815bef9e-609e-4d94-882b-bbffee4b3cda.jpg" width="300" height="600" /> 
  <img src="https://user-images.githubusercontent.com/72159017/221246705-147872fd-178b-4619-a610-a529445ab6ee.jpg" width="300" height="600" />
</p>
</div>
   <br>
  
  
### Election Vote History Page
<div id="ElectionVoteHistory">
<br>
<p aligh="middle">
  <img src="https://user-images.githubusercontent.com/72159017/221247051-2fd19cc8-d9c1-4526-bfda-39751a98076d.png" width="300" height="600" />
</p>
  </div>
   <br>



