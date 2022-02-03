import {
  getValidActor,
  validSocketArguments,
} from "../../utils/commonUtilities.js";
import { SERVER_REQUEST_EVENTS } from "../../events/serverRequestEvents.js";
import { FOUNDRY_EVENTS } from "../../events/foundryEvents.js";
import { CORE_EVENTS } from "../../events/coreEvents.js";

export function handleDisplayEvents(socket) {
  Object.values(SERVER_REQUEST_EVENTS.DISPLAY).forEach((displayEvent) => {
    socket.on(displayEvent, (...args) => {
      handleDisplayEvent(displayEvent, socket, ...args);
    });
  });
}

export function handleDisplayEvent(displayEvent, socket, args) {
  switch (displayEvent) {
    case CORE_EVENTS.ITEM:
      if (validSocketArguments(socket, displayEvent, args, 1)) {
        displayItemCard(args[0]);
      }
      break;
    case SERVER_REQUEST_EVENTS.DISPLAY.CHAT_DATA:
      if (validSocketArguments(socket, displayEvent, args, 3)) {
        createAndEmitChatData(socket, args[0], args[1], args[2]);
      }
      break;
    case SERVER_REQUEST_EVENTS.DISPLAY.CHAT_MESSAGE:
      if (validSocketArguments(socket, displayEvent, args, 3)) {
        createChatMessage(args[0], args[1], args[2]);
      }
      break;
    default:
    //TODO: Some error
  }

  function createAndEmitChatData(socket, userId, actorId, iosSocketId) {
    let chatMessages = game.messages;
    let actor = getValidActor(socket, actorId, iosSocketId);
    if (actor && chatMessages) {
      socket.emit(
        FOUNDRY_EVENTS.CHAT_DATA,
        chatMessages
          .filter(
            (chatMessage) =>
              chatMessage.data.type !== 4 ||
              (chatMessage.data.whisper &&
                chatMessage.data.whisper.includes(userId)) ||
              chatMessage.data.user === userId
          )
          .map((chatMessage) => {
            let chatData = chatMessage.data;
            let chatMessageToRespond = {
              id: chatData._id,
              content: jQuery("<p>" + chatData.content + "</p>").text(),
              timestamp: chatData.timestamp,
              userId: chatData.user,
              isCurrentUser: chatData.user === userId,
              isWhisper: chatData.type !== 4,
            };

            if (chatData.speaker && chatData.speaker.alias) {
              chatMessageToRespond.speaker = chatData.speaker.alias;
            } else if (chatData.user) {
              let user = game.users.get(chatData.user);
              if (user) {
                chatMessageToRespond.speaker = user.name;
              }
            }

            if (chatData.flavor) {
              chatMessageToRespond.chatFlavor = chatData.flavor;
            }

            if (chatData.whisper && chatData.whisper.length) {
              chatMessageToRespond.whisperUsers = chatData.whisper.map(
                (userId) => game.users.get(userId).name
              );
            }

            return chatMessageToRespond;
          }),
        iosSocketId
      );
    }
  }

  function createChatMessage(userId, actorId, message) {
    let user = game.users.get(userId);
    let actor = game.actors.get(actorId);
    if (user && actor && message) {
      let chatMessageOptions = {
        speaker: ChatMessage.getSpeaker({ actor: actor }),
        content: message,
      };
      ChatMessage.create(chatMessageOptions);
    }
  }

  function displayItemCard(displayItem) {
    let displayItemObj = JSON.parse(displayItem);
    let actor = game.actors.get(displayItemObj.actorId);
    let item = actor.items.get(displayItemObj.itemId);

    if (actor && item && displayItemObj) {
      item.displayCard().then(() => {
        // do nothing
      });
    }
  }
}
