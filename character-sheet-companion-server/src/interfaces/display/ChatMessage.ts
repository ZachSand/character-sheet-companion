export interface ChatMessage {
  id: string;
  speaker: string;
  userId: string;
  isCurrentUser: boolean;
  content: string;
  chatFlavor: string;
  timestamp: number;
  whisperUsers: string[];
}
