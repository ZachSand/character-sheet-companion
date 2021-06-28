import config from "./config";
import express from "express";
import Logger from "./loaders/logger";
import loaders from "./loaders";
import http from "http";
import { Server } from "socket.io";
import { IUser } from "./interfaces/IUser";
import { IActor } from "./interfaces/IActor";
import { IActorAbility } from "./interfaces/IActorAbility";

async function startServer() {
  const app = express();
  await loaders({ expressApp: app });
  const server = http.createServer(app);
  const io = new Server(server, {
    cors: {
      origin: "http://localhost:30000",
      methods: ["GET", "POST"],
    },
  });
  server
    .listen(config.port, () => {
      Logger.info(`
      ################################################
          Server listening on port: ${config.port}
      ################################################
    `);
    })
    .on("error", (err) => {
      Logger.error(err);
      process.exit(1);
    });

  io.on("connection", (connectedSocket) => {
    let user: IUser;
    let actor: IActor;
    connectedSocket.on("users", (users: Array<IUser>) => {
      user = users[0];
      connectedSocket.emit("userActors", user.userId);
    });

    connectedSocket.on("actors", (actors: Array<IActor>) => {
      actor = actors[0];
      connectedSocket.emit("userActor", actor.actorId);
    });

    connectedSocket.on("actorAbilities", (abilities: Array<IActorAbility>) => {
      abilities.forEach((ability) => Logger.info(ability.abilityName));
      connectedSocket.emit("abilityCheck", "str", actor.actorId);
    });
  });
}

startServer();
