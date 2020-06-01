export function AudioDelay(M) {
    const maxDelay = 44100;
    const m = M > maxDelay ? maxDelay : M;
    const buffer = new Float32Array(maxDelay);
    let pW = maxDelay;
    let pR = pW - m;


    return (soundData)=>{
        

    }
}


