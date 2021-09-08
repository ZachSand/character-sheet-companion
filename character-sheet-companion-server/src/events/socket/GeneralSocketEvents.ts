import { EVENT_TYPES } from "../eventTypes";

export class GeneralSocketEvents implements SocketEvents {
  private static _instance: GeneralSocketEvents;
  GENERAL_EVENTS = {
    DISCONNECT: "disconnect",
  };

  private constructor() {
    //No Op -> Singleton
  }

  public static get Instance(): GeneralSocketEvents {
    return this._instance || (this._instance = new this());
  }

  public getFromBaseEvent(event: string): string {
    return EVENT_TYPES.SOCKET.FOUNDRY + event;
  }

  public getEvents(): string[] {
    return Object.values(this.GENERAL_EVENTS);
  }
}
