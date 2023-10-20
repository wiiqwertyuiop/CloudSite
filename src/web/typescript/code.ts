async function test(): Promise<string> {
    const raw = await fetch('https://us-central1-wiiq-proj.cloudfunctions.net/on_request_example', {
        method: 'GET',
    });
    console.log(raw);
    if (!raw.ok) {
        return "bad response";
    }
    return await raw.text();
}

test().then((out: string) => {
    document.getElementById("out").innerHTML = out;
}).catch((_) => {
    document.getElementById("out").innerHTML = _;
});


