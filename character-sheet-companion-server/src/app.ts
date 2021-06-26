import config from "./config";
import express from "express";
import Logger from "./loaders/logger";
import loaders from "./loaders";
import http from "http";
import { Server } from "socket.io";

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
      Logger.info(`
      ################################################
      🛡️  Server listening on port: ${config.port} 🛡️
      ################################################
    `);
    })
    .on("error", (err) => {
      Logger.error(err);
      process.exit(1);
    });

  io.on("connection", (socket) => {
    Logger.info("a user connected");
  });
}

startServer();
