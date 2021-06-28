Hooks.on("ready", async () => {
    let socket = io.connect("http://localhost:3000");
    let users = [];
    game.users.forEach(user => {
        let userModel = {
            'userId': user.data._id,
            'isActive': user.active,
            'userName': user.data.name
        };
        users.push(userModel);
    });
    socket.emit("users", users);

    socket.on("userActors", userId => {
        let user = game.users.get(userId);
        let userActors = game.actors;
        if(!user.isGM) {
            userActors.filter(actor => actor.getUserLevel(user) === CONST.OWNER);
        }
        let userActorData = [];
        game.actors.forEach(actor => {
            let userActor = {
                'actorId': actor.data._id,
                'name': actor.data.name
            }
            userActorData.push(userActor);
        });
        socket.emit("actors", userActorData);
    });

    socket.on("userActor", actorId => {
        let gameActor = game.actors.get(actorId);
        let actorAbilities = [];
        Object.entries(gameActor.getRollData().abilities).forEach(ability => {
            let abilityData = {
                'abilityName': ability[0],
                'checkBonus': ability[1].checkBonus,
                'dc': ability[1].dc,
                'max': ability[1].max,
                'min': ability[1].min,
                'mod': ability[1].mod,
                'prof': ability[1].prof,
                'proficient': ability[1].proficient,
                'save': ability[1].save,
                'saveBonus': ability[1].saveBonus,
                'value': ability[1].value
            };
            actorAbilities.push(abilityData);
        });
        socket.emit("actorAbilities", actorAbilities);
    });

    socket.on("abilityCheck", (abilityId, actorId) => {
        let gameActor = game.actors.get(actorId);
        console.log(gameActor.rollAbilityTest(abilityId, {'fastForward': true}));
    });

});