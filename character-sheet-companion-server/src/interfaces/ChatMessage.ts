export interface ChatMessage {
  actorId: string;
  speakerAlias: string;
  content: string;
  chatFlavor: string;
  timestamp: number;
  isWhisper: boolean;
}
