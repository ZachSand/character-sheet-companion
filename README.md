# character-sheet-companion

Character Sheet Companion is a project for using an iOS application to play with your party in real time in the Foundry Virtual Tabletop application and the D&D 5E system. Actions taken on the FVTT browser application (the default way to play the game) will propagate to the iOS application, and vice versa. That means you can roll skill checks, saving throws, attacks and more in the iOS application and have those rolls happen in real time on the FVTT application. The DM can modify your actor in the browser application and those changes will also occur in the iOS application in real time even though you didn't take part in those actions. 

The iOS and FVTT module communicate through web sockets to notify each other of events that happen on either side of the connection. 

## Stale/Incomplete

I started this project as a way to use the FoundryVTT somewhat natively on an iOS device. I haven't 
had the time to pick it back up again and get it to a more complete state.
FoundryVTT has had a lot of updates since originally working on this that I haven't incorporated. When I stopped working on it, it was functional but wasn't nearly where I wanted it to be for a complete application. 

**I'm writing this README 6 months since I've touched this project so I'm probably not describing everything correctly**

## Overview

There are three parts to how this application works as a whole

 - character-sheet-compantion-client
 -- This is the FoundryVTT add on module that uses SocketIO websockets to communicate to the server. At the time of writing the application, FVTT already used SocketIO for communication so it was easiest to leverage that capability from the core product. 
 
- character-sheet-companion-server 
-- A Node Express server using SocketIO for communication between the FoundryVTT module and the iOS application. Acts as middleware/middleman between the mobile application and the FVTT module. 

- CharacterSheetCompanion 
-- Swift iOS application using SwiftUI

## How it works

### FVTT Module
The character-sheet-companion-client is built as a FoundryVTT module. This module uses a SocketIO client, connecting to the character-sheet-companion-server, to listen for events. Some example events are retrieving and updating actor information, retrieving and sending roll results, the inital connection setup events etc. The module will also listen for hooks in the game, such as an actor taking damage, to send to the node sever which subsequently sends to the iOS application for the user controlling that actor. 

The brute-force approach for authentication and tying a FVTT session with an iOS user is based on the UUID that is generated and put in the module settings in FVTT. That UUID is needed when connecting on the iOS app. Behind the scenes, that UUID is setup as the room ID for the SocketIO room that is setup for communication.

### Node Server
The node server (typescript, express, socketIO, etc.) acts as the middle layer between the FVTT module and the iOS application/user. This is needed because both the iOS application and the FVTT module are only capable of acting as socketIO clients so there needs to be a server to manage and connect with the clients. 

The server is event driven based on SocketIO events that are sent and received from the FVTT module and iOS application. 

### iOS Application
The Swift & SwiftUI iOS application uses a SocketIO Swift library for connecting and communicating with the Node server. The flow is essentially

1. Get UUID from FoundryVTT module settings
2. Enter UUID into login/connect screen on iOS application
3. Choose a user and an actor 
4. Load all of that actor's information
5. Get multiple screens of that actor's information such as spells, attributes, equipment, health, picture, etc. 
6. Choose actions, equipment, skills, attributes, etc. on the iOS application, choose to roll/use, that propagates to the FoundryVTT application and the results propagate back to the iOS application
7. Similar capabilities with health, level, equipment

### How to run

To run this you will need a FVTT license to run the application. In the FVTT application with the D&D 5E System installed, import the module.json file from the character-sheet-companion-client project. This will "install" the module into your local copy of FVTT. 

The `character-sheet-companion-server` needs to run first by running `yarn start`. Then you can start the FVTT world with the D&D5E system. Enable the module, it should connect with the server after enabled and the world refreshes. 

Go to FoundryVTT module settings and copy the UUID generated for the module. 

Open the CharacterSheetCompanion iOS application in Xcode. Run the application in debug mode using an iOS device simulator. A screen should pop up where you can enter the UUID. This will connect the iOS application to the server and establish a SocketIO room between the iOS application and the FVTT application that is running the module. 

On the iOS application, choose a user and actor (and enter the password if there is one), wait for the actor data to load. From here you can roll actions, skills, spells, items, etc. You can view the attributes of the actor, all the spells, all the equipment, etc. As long as it is on the actor in FVTT it should also show up in the iOS application. 

