# RS mobile: Setup Flutter|Android Studio build environment
## Windows
### Assumptions 
(These may be adapted to your needs.)

- Clean environment yet without any dart, flutter or android studio
- FlutterRoot: c:\
- FlutterDir:    $(FlutterRoot)\flutter
- AndroidStudioRoot: c:\
- AndroidStudioDir: $(AndroidStudioRoot)\AndroidStudio 
- RSMobileDir: c:\RS-Mobile
- RSPlatformTools: C:\Users\LOCALWINUSERNAME\AppData\Local\Android\Sdk\platform-tools

### Steps
#### Flutter installation
1. Download and install any flavour of git for windows.  
   (see: https://flutter.dev/docs/get-started/install/windows#system-requirements)
2. Download Flutter stable:  
   https://flutter.dev/docs/get-started/install/windows#get-the-flutter-sdk
3. Open the zip-package and copy the contained flutter-dir to FlutterRoot.  
This results in the FlutterDir.
4. Add in environment variables of your account to the PATH-variable of USER context separated by ';' the explicit full path to flutter\bin: $(FlutterDir)\bin
   1. Test:   
     Start a cmd console  (in START/RUN type: `cmd`)
   2. type:  
      `flutter -h <return>`   
      flutter should show you its help text if all is well until now.
5. in cmd type:  
   `flutter doctor <return>`   
   - flutter checks its environment and will most likely tell you, that
     - Android SDK is missing
     - Android Studio is missing
     - it may also query for chrome but this is not needed

#### Android Studio installation
1. install Android Studio for windows:  
   https://developer.android.com/studio
   - follow the default setting and ensure the installation is done to AndroidStudioDir
2. After installation start Android Studio and let it update if it queries for some
3. press NEXT-buttons until it is no longer shown
4. press FINISH and follow until finish
5. On Wellcome-Page go into plugins and
  - install dart 
  - and flutter 
  - and let AS restart
6. On welcome page select projects: More Action/SDK Manager and than Tab SDK-Tools.
   - Ensure all "Android SDK"* Entries are installed and especially
   - ensure "Android SDK command line tools" to be installed
7. Close the SDK Dialog
8. If you wish to use simulated mobiles you may later select in "more actions" AVD Manager and create emulated devices as you need.

#### Associate Flutter and Android Studio
1. tell Flutter where to find AS:    
   in cmd console type:  
   ``flutter config --android-studio-dir "$(AndroidStudioDir)"``  
   The quotes are mandatory if the path conatains for exc. BLANKs
2. now you need to accept the SDK licenses:  
   in md type:  
   ``flutter doctor --android-licenses``  
   and accept all.

#### Final check of flutter installation
- In new cmd-console type:  
  ``flutter doctor ``  
  it should now tell all (but maybe chrome) is OK.

# RS mobile: Prepare project

## Main package
1. Git: clone RS mobile locally as RSMobileDir  
(https://github.com/RetroShare/retroshare-mobile)
2. Open a cmd window (type cmd in START)
3. change directory into RS mobile dir
4. type:  
``flutter pub get<return>``  
to update the flutter package dependancies as needed in the project.
5. open the RSMobileDir in Android Studio 

### Prepare your Project for use with emulated devices
1. Within the opened Android Studio on the left side in the project-tab open the path:  
   "retroshare-mobile/android/app/src/main/java/io/GeneratedPluginRegistrant.java"
2. Start "GeneratedPluginRegistrant.java" by dobbleclick on it.
3. On the right side on top of the opened registrant:  
   if you see a note "Module SDK is not defined",  
   than click the button "Setup SDK" on the right side of this note.
4. In the opened dialog select any android SDK and click OK.
5. Restart Android Studio.

Now your project - this is to do in any new project - is able to define and use emulated Phones.

# Activate USB Debug Mode of the mobile
1. in settings type usb in search
2. select usb-debugging
3. activate it
4. plug the mobile with usb to the pc
5. if this is the first time a dialog appears to accept the key; accept it
6. check in cmd console if the device is available
    - cmd:  
      ``flutter devices<return>``  
      should now list your mobile as availabel 

# Run the apk on mobile
## Install the service apk on the mobile
### a) physical mobile
1. plug in the USB of the phone
2. activate: USB-usage file transfer
3. load the service apk to the mobile and install it

### b) emulated phone (but not only)
1. For your convenience:  
   Add in environment variables of your account to the PATH-variable of USER context separated by ';' the explicit full path to the command_tools: $(RSPlatformTools) where the adb.exe houses which we will need.
2. Open a cmd-console within the directory of your service apk
3. type in cmd:  
   ``adb install "YOUR_SERVCIE_APK.apk" <return>``

## Run the RestroShare Mobile

Type in cmd console:  

    flutter run [[--release]]<return>

without release it will run in debug mode

# Debugging and Tracing
## Debuging RS-Mobile
RS-Mobile is debugable simply with Android-Studio as usual with. Just intuitiv and relative comfortable.
## Tracing RS-mobile in the context of the android-activities
Open a cmd-console in the directory of the android ../sdk/patform-tools.
There you will find the adb.exe (Android Debug Bridge).
This tool enables you for excample to get the tracefiles from your android-device 
by  

    adb logcat > trace.txt<return>

You may filter the content of trace.txt than by "restroshare" to get only the lines of the client and the service without other android contextual activities.


## Debugging RS-Service-Apk
TBD; actual not knwon how to setup a debug-environment fort it.  
Hints in context: https://gitlab.com/elRepo.io/elRepo.io-android/-/issues/43

## Tracing RS-Service in the context of the android-activities
As above with the adb.exe tool.  
If you want manually check the communication interface of the servcice
you may use the cUrl tool.  
To use it you must establich a redirection of the ports by:  

    adb forward tcp:9091 tcp:9092

than you should be able to talk to the servcie direcly  
for exc. like:

    curl http://127.0.0.1:9091/RsJsonApi/version -v

This would for exc generate an output like  

    Trying 127.0.0.1...  
    TCP_NODELAY set  
    Connected to 127.0.0.1 (127.0.0.1) port 9091 (#0)
    GET /RsJsonApi/version HTTP/1.1  
    Host: 127.0.0.1:9091  
    User-Agent: curl/7.55.1  
    Accept: */*  
    
    HTTP/1.1 200 OK  
    Access-Control-Allow-Headers: Authorization,DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range  
    Access-Control-Allow-Methods: GET, POST, OPTIONS  
    Access-Control-Allow-Origin: *  
    Access-Control-Expose-Headers: Content-Length,Content-Range  
    Connection: close  
    Content-Length: 116  
    Content-Type: application/json  
      
    {"major": 0,  
     "minor": 6,  
     "mini": 6,  
     "extra": "-38-g25f58bc10",  
     "human": "0.6.6-38-g25f58bc10"  
    }* Closing connection 0
