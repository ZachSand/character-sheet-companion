import { SetupActor } from "./SetupActor";

export interface SetupUser {
  id: string;
  isActive: boolean;
  name: string;
  actors: SetupActor[];
}
