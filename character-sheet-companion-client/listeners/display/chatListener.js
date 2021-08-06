import { SOCKET_EVENTS } from "../../events/events.js";

export function createAndEmitChatData(socket, userId, actorId, iosSocketId) {
  let chatMessages = game.messages;
  let actor = game.actors.get(actorId);
  if (actor && chatMessages) {
    socket.emit(
      SOCKET_EVENTS.FOUNDRY.SEND_CHAT_DATA,
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

export function createChatMessage(userId, actorId, message) {
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
