import { createServer } from "http";
import { Server } from "socket.io";
import Client from "socket.io-client";
import { AddressInfo } from "net";
import { actorDataListener } from "../../src/listeners/setup/actorDataListener";
import { SOCKET_EVENTS } from "../../src/constants/events";

describe("foundry data actor handler", () => {
  let io, serverSocket, clientSocket;

  beforeAll((done) => {
    const httpServer = createServer();
    io = new Server(httpServer);
    httpServer.listen(() => {
      const addressInfo = httpServer.address() as AddressInfo;
      clientSocket = Client(`http://localhost:${addressInfo.port}`);
      io.on("connection", (socket) => {
        serverSocket = socket;
        actorDataListener(io, socket);
      });
      clientSocket.on("connect", done);
    });
  });

  afterAll(() => {
    io.close();
    clientSocket.close();
  });

  test("iOs send actor data request, should receive request", (done) => {
    const expectedActorId = "actorId";
    clientSocket.emit(
      SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ACTOR_DATA,
      expectedActorId
    );

    serverSocket.on(
      SOCKET_EVENTS.IOS.REQUEST_FOUNDRY_ACTOR_DATA,
      (actualActorId: string) => {
        expect(actualActorId).toBe(expectedActorId);
        done();
      }
    );
  });
});
