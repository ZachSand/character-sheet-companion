Hooks.on("ready", async () => {
    let socket = io.connect("http://localhost:3000");
    console.log(socket);
});