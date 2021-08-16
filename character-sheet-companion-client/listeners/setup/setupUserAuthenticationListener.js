export async function userAuthListener(socket, userId, password, iosSocketId) {
  await verifyUserAuth({
    userid: userId,
    password: password,
    adminKey: "",
    action: "join",
  }).then((response) => {
    if (response.ok) {
      socket.emit(SOCKET_EVENTS.FOUNDRY.SETUP.USER_AUTH, true, iosSocketId);
    } else {
    }
  });

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
}
