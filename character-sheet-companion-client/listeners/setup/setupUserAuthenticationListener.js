import { SOCKET_EVENTS } from "../../constants/events.js";

export async function userAuthListener(socket, setupUserAuth, iosSocketId) {
  let setupUserAuthObj = JSON.parse(setupUserAuth);
  if (setupUserAuthObj) {
    await verifyUserAuth({
      userid: setupUserAuthObj.id,
      password: setupUserAuthObj.password,
      adminKey: "",
      action: "join",
    }).then((response) => {
      if (response.ok) {
        setupUserAuthObj.passwordMatches = true;
        socket.emit(
          SOCKET_EVENTS.FOUNDRY.SETUP.USER_AUTH,
          setupUserAuthObj,
          iosSocketId
        );
      } else {
        setupUserAuthObj.passwordMatches = false;
        socket.emit(
          SOCKET_EVENTS.FOUNDRY.SETUP.USER_AUTH,
          setupUserAuthObj,
          iosSocketId
        );
      }
    });
  }
}

function verifyUserAuth(data) {
  return fetch("join", {
    method: "POST",
    mode: "cors",
    cache: "no-cache",
    credentials: "same-origin",
    headers: {
      "Content-Type": "application/json",
    },
    referrerPolicy: "strict-origin-when-cross-origin",
    body: JSON.stringify(data),
  });
}
