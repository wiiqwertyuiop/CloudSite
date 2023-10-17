async function test() {
    const raw = await fetch('https://us-east1-wiiq-proj.cloudfunctions.net/hello', {
        method: 'GET',
    });
    console.log(raw);
    if (!raw.ok) {
        return "bad response";
    }
    return await raw.text();
}
test().then((out) => {
    document.getElementById("out").innerHTML = out;
}).catch((_) => {
    document.getElementById("out").innerHTML = _;
});
