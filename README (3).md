
# skiCentar




## Login Credentials - Desktop App

**Administrator Login**

```plaintext
E-mail: admin@email.com
Password: test
```

**Employee Login**

```plaintext
E-mail: user@email.com
Password: test
```


 

## Login Credentials - Mobile App

**User Login**

```plaintext
E-mail: user@email.com
Password: test
```

**Payment Card Number**
```plaintext
4242 4242 4242 4242
CVC: 123
```
## Running the Applications

1. Clone the repository
```plaintext
 https://github.com/DautbegovicDavid/ski-cent
 ```

2. Open the cloned repository in the console

3. Start the Dockerized API and DB
```plaintext
  docker-compose build
  docker-compose up
```
4. Running the desktop application through Visual Studio Code

**Open the skiCentar folder**

**Open the UI folder**

**Choose the skicentar_admin folder f**

**Fetch dependencies**
```plaintext
  flutter pub get
```
**Run the desktop application with the command**
```plaintext
 flutter run -d windows
```
5. Running the mobile application through Visual Studio Code

**Open the skiCentar folder**

**Open the UI folder**

**Choose the skicentar_mobile folder**

**Fetch dependencies**
```plaintext
  flutter pub get
```
**Start the mobile emulator**

**Run the mobile application without debugging CTRL + F5**

6. Running RabbitMQ through Visual Studio

**Choose eskiCentar.Subscriber as the startup project and run it.**

7. Minor notes:

**To test user registration, follow these steps:**

- Register a new user account on the application.
- Log in to the email account used for registration.
- Check the **Inbox** and **Spam** folder for a confirmation email.
- Open the email and click on the link inside to confirm the registration.
