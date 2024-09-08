
# skiCentar




## Login Credentials - Desktop App

**Administrator Login**

```plaintext
E-mail: admin@email.com
Password: test
```

**Employee Login**

```plaintext
E-mail: employee@email.com
Password: test
```


 

## Login Credentials - Mobile App

**User Login**

```plaintext
E-mail: user@email.com
Password: test
```

**Employee Login**

```plaintext
E-mail: employee@email.com
Password: test
```

**Payment Card Number**
```plaintext
4242 4242 4242 4242
CVC: 123
```
## Running the Applications

IMPORTANT - version of flutter is 13.19.4

1. Clone the repository
```plaintext
 https://github.com/DautbegovicDavid/ski-centar
 ```

2. Open the cloned repository in the console

3. Start the Dockerized API and DB
```plaintext
  docker-compose build
  docker-compose up
```
4. Running the desktop application through Visual Studio Code

- Open the skiCentar folder

- Open the UI folder

- Choose the skicentar_desktop folder 

- Fetch dependencies
```plaintext
  flutter pub get
```
- Run the desktop application with the command
```plaintext
 flutter run -d windows
```
5. Running the mobile application through Visual Studio Code

- Open the skiCentar folder

- Open the UI folder

- Choose the skicentar_mobile folder

- Fetch dependencies
```plaintext
  flutter pub get
```
- Start the mobile emulator

- Run the mobile application without debugging CTRL + F5

6. Running RabbitMQ through Visual Studio

- Choose eskiCentar.Subscriber as the startup project and run it.

7. Minor notes:

To test user registration, follow these steps:

- Register a new user account on the application.
- Log in to the email account used for registration.
- Check the **Inbox** and **Spam** folder for a confirmation email.
- Open the email and click on the link inside to visit app and confirm the registration.
- For registration link to work you need to click on it inside device (AVD) either log in to your email on simulator or copy link from email into virtual device and click on it 

  Notifications
- either use notifications controller or create ski accident
- for Android 13+ enable notifications in settings -> https://github.com/llfbandit/app_links/blob/master/doc/README_android.md

Ski accidents
for user to be able to report ski accident he needs to have ski ticket purchased
after succesfull purchase he will get red button on left bottom side on SKI MAP screen

Tickets
to but ticket user can go from home screen to "see more" section on ski tickets widget

env files x2 and fcm conf file required for testing
