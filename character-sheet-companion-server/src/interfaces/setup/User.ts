import { Actor } from "./Actor";

export interface User {
  id: string;
  isActive: boolean;
  name: string;
  actors: Actor[];
}
