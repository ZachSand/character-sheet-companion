export const IOS_DATA_MAP = new Map();

export function setupIosCompleteListener(actorId, userId, iosSocketId) {
  IOS_DATA_MAP.set(actorId, {
    userId: userId,
    iosSocketId: iosSocketId,
  });
}
