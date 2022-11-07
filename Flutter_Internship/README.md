# flutter_internship

Test task flutter project "Weather", which implements the search for a city and the weather in it, using Api Openwether.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab:](https://docs.flutter.dev/get-started/codelab)
- [Cookbook:](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

A Free Weather API key from  https://openweathermap.org/  was writen in file api_key with one variable, that is used by methods in other class.

Figma design is here https://www.figma.com/file/MV15v0asVZlLyYCJvoXXth/SK-Internship-Weather-App?node-id=1623%3A2 

## Beggining
These instructions will help you get up and running a copy of the project on your local machine for development and testing purposes.
The project works almost autonomously, all the necessary dependencies are in the pubspec.yaml file. 

## Installation 
Installation instructions.
To test the project, it is best to use the Android mobile device emulator.

## Application 
To search for a city, you need to enter a name of city in the text field, then if you type the city correctly and find it in the openweather server DB, the answer will be received and presented in the drop-down list below the search field. You can get the current weather of the city by clicking on the name of the city  in the drop-down list, or by pressing the "Accept" button on the device's keyboard, or on the search button with a magnifying glass icon. If the city is not in the database of the openweather server or such a city does not exist, the drop-down list will result in the text "city not found".
When entering a city name, sometimes the state may not update immediately, so it is sometimes recommended to insert one space after the city name.
Buttons for obtaining current weather information in popular cities also work, for this, just click on the button on the card of a popular city and scroll up.
Also, drop-down information from frequently asked questions and a footer with dynamic information of the current year work.

## Developer
Developer Vladyslav Rokytenko.