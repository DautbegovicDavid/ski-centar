
# skiCentar

The SkiCentar project is a comprehensive software solution that caters to both clients and administrators in ski.. The project encompasses a mobile app for clients and a Windows forms application for administration.


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

**Choose eCakeShop.Subscriber as the startup project and run it.**

7. Minor notes:

**Due to limitations, use the address of a larger locality (Sanica, Donji Kamengrad, Mostar, etc.).**

**Outlook emails may not receive confirmations due to Microsoft's spam filters. Consider using alternative email platforms like Gmail or ProtonMail.**

**The small image count is designed to optimize Docker build speed.**