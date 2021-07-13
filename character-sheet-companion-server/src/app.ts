import config from "./config";
import express from "express";
import Logger from "./loaders/logger";
import loaders from "./loaders";
import http from "http";
import { Server, Socket } from "socket.io";
import { socketHandlerWrapper } from "./handlers/socketHandlerWrapper";

async function startServer() {
  const app = express();
  await loaders({ expressApp: app });
  const server = http.createServer(app);
  const io = new Server(server, {
    cors: {
      origin: "*",
      methods: ["GET", "POST"],
    },
  });
  server
    .listen(config.port, () => {
      Logger.info(`Server listening on port: ${config.port}`);
    })
    .on("error", (err) => {
      Logger.error(err);
      process.exit(1);
    });

  const onConnection = (socket: Socket) => {
    socketHandlerWrapper(io, socket);
  };

  io.on("connection", onConnection);
}

startServer();
