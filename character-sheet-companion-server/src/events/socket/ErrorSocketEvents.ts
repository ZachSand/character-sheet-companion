import { EVENT_TYPES } from "../eventTypes";

export class ErrorSocketEvents implements SocketEvents {
  private static _instance: ErrorSocketEvents;
  ERROR_EVENTS = {
    SETUP: {
      ROOM_EMPTY: "RoomEmpty",
      ROOM_MISSING: "RoomMissing",
    },
    GENERAL: {
      ERROR: "error",
    },
  };

  private constructor() {
    //No Op -> Singleton
  }

  public static get Instance(): ErrorSocketEvents {
    return this._instance || (this._instance = new this());
  }

  public getFromBaseEvent(event: string): string {
    return EVENT_TYPES.SOCKET.FOUNDRY + event;
  }

  public getEvents(): string[] {
    return Object.values(this.ERROR_EVENTS.GENERAL).concat(
      Object.values(this.ERROR_EVENTS.SETUP)
    );
  }
}
