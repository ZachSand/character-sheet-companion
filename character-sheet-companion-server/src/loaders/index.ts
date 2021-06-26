import expressLoader from "./express";
import Logger from "./logger";
//We have to import at least all the events once so they can be triggered

export default async ({ expressApp }) => {
  await expressLoader({ app: expressApp });
  Logger.info("✌️ Express loaded");
};
