interface SocketEvents {
  getEvents(): string[];

  getFromBaseEvent(baseEvent: string): string;
}
