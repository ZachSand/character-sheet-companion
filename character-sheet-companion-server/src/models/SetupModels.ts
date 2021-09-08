export interface SetupActor {
  id: string;
  name: string;
}

export interface SetupUsers {
  users: SetupUser[];
}

export interface SetupUser {
  id: string;
  isActive: boolean;
  name: string;
  actors: SetupActor[];
}

export interface SetupUserAuth {
  id: string;
  password: string;
  passwordMatches: boolean;
}

export interface SetupWorldData {
  id: string;
  title: string;
  version: string;
  system: string;
  coreVersion: string;
  description: string;
}
