async function test(): Promise<any> {
    const raw = await fetch('https://us-east1-wiiq-proj.cloudfunctions.net/hello', {
        headers: {
            Accept: 'text/plain',
            'Content-Type': 'text/plain',
        },
        method: 'GET',
    });
    if (!raw.ok) {
        console.log(raw);
        return "bad response";
    }
    const response = raw.text;
    return response;
}

test().then((out: string) => {
    document.getElementById("out").innerHTML = out;
}).catch((_) => {
    //window.location.href = "error.html";
});


