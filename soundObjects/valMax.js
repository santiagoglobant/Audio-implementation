export function valMax(audio){
    return audio.map(val => Math.abs(val)).reduce((curr, obj) => curr > obj ? curr : obj, 0);
}