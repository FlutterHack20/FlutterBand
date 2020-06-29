[![Codemagic build status](https://api.codemagic.io/apps/5ef7d9cb7901d81e0cfcf8e5/5ef7d9cb7901d81e0cfcf8e4/status_badge.svg)](https://codemagic.io/apps/5ef7d9cb7901d81e0cfcf8e5/5ef7d9cb7901d81e0cfcf8e4/latest_build)

# flutterband

The Flutterbuck team have gone retro!
The citizen band radio, or CB, was the pre-social media communication platform that gained popularity from the late 1970s through to the 90s.  But, the rise in accessibility to the world-wide-web and mobile phone technology saw the masses shift to platforms new.
But today’s social media provision has lost the anonymity and random connection opportunity that the CB platform offered.  So, the The Flutterpuck team think it’s time for a CB resurgence, and we’d like to introduce you to… Flutterband.
A fusion of the old and the new, we’ve taken a skeuomorphic design approach to retain the retro flavour of the physical rig from back in the day, and added new functionality to give the CB relevance for today’s global community.
Simply switch on broadcasting with this button and speak your message.


(Demo)
(Sender English) “This is Midnight Rider. Find me on channel 17 to talk about trainspotting in Europe?”
Flutterband then converts this to text, detects the language and stores these on a Firestore back end before sending the message to all listener units, where the text message is translated to the receiving system language which is displayed on the rolling text screen and also converted to audio.
(Demo)


(Receiver French):  “Voici Midnight Rider. Retrouvez-moi sur la chaîne 17 pour parler du trainspotting en Europe? “
(Receiver Portuguese):  “Este é o Cavaleiro da Meia-Noite. Encontre-me no canal 17 para falar sobre trens na Europa?”


Users then turn the knob to switch to an unoccupied channel to continue their conversation away from the noise of the crowd in channel 1.
We’re paying homage to CB radio with features like the channel selector knob and a frequency indicator on the UI, and even some authentic sound effects to stimulate a little nostalgia,
We’ve also tried to improve upon some of the ethical pitfalls of yesteryear, guarding personal safety with the use of random voices, rather than your own.  This greatly reduces the capacity for demographic stereotyping, and makes it far more difficult for any user with dark intentions to detect vulnerability.  No personal details are made available, enabling users to remain completely anonymous if they so wish.  And if you should find yourself on a channel with a weirdo, simply leave the channel, without consequence.

Flutterband is a fun interactive experience where you can have uncensored conversations with your friends or make new friends from anywhere in the world with no need for typing. 

###### DOWNLOADS
[APK](https://api.codemagic.io/artifacts/31c50b23-ddce-4866-a2e2-d2b3011d53b1/e2287dcf-d1cc-45b8-bcaf-f8aace7aef45/app-debug-universal.apk)
[AAB](https://api.codemagic.io/artifacts/88c393ae-60d5-463f-8efc-515634a61673/f1979949-ce65-4566-a78a-d5bfb6cc91b2/app-debug.aab)


###### Technologies:
- Flutter and BLoC state management library
- Firebase for realtime database and communication
- Google APIs for Translation
- Text-to-speech and speech-to-text transformations on the fly
- Audio playback for translated messages and some sound effects as well
- Flare animations for all control widgets and animation manipulation, such as for the knob

![alt text](https://i.imgur.com/QiuOK2J.gif)

###### TEAM

*Mat Wright [Twitter](https://twitter.com/_MatWright)

*Terry Rees

*Arnaud [GitHub](https://github.com/arnaud-soulie/)

*Rui Lima [GitHub](https://github.com/rapzo) [Twitter](https://twitter.com/rapzo)

*Jason [Rive](https://rive.app/a/SquidLiquid/files/recent/all)

###### VIDEO

[![Alt text](https://img.youtube.com/vi/BG5URpaySxc/0.jpg)](https://youtu.be/BG5URpaySxc)


