const outTarget = "out";

async function getWord(): Promise<string> {
    const raw = await fetch('https://us-east1-wiiq-proj.cloudfunctions.net/last_word', {
        method: 'GET',
    });
    console.log(raw);
    if (!raw.ok) {
        return "bad response";
    }
    return await raw.text();
}

function resizeFont() {
    // Cheap hacky way of resizing font to fit on one line
    const containerWidth = document.getElementById(outTarget).offsetWidth;
    const maxWidth = document.getElementsByClassName("content")[0].clientWidth;
    if (containerWidth < maxWidth) {
        return;
    }
    const reduceBy = document.getElementsByClassName("content")[0].clientHeight * 0.03;
    const fontSize = getComputedStyle(document.getElementById(outTarget)).fontSize;
    const size = Number(fontSize.slice(0, -2));
    const ratio = Math.floor(containerWidth / maxWidth);
    document.getElementById(outTarget).style.fontSize = (size - (reduceBy*ratio)) + "px";
}

getWord().then((out: string) => {
    document.getElementById("out").innerHTML = out;
}).catch((_) => {
    document.getElementById(outTarget).innerHTML = _;
}).finally(() => resizeFont());
onresize = (_) => { 
    document.getElementById(outTarget).style.fontSize = "";
    resizeFont(); 
};



