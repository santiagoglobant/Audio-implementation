// import { Observable, Subject, ReplaySubject, from, of, range, combineLatest, forkJoin } from 'https://dev.jspm.io/rxjs@6/_esm2015';
// import { map, filter, delay, switchMap, debounceTime, mergeMap, concatMap } from 'https://dev.jspm.io/rxjs@6/_esm2015/operators';
// import { songs } from './songs.mock.js'
// import { guitarPlayer } from './guitarPlayer.mock.js';
import { AudioController } from './soundObjects/audioController.js'
import { schroederV3 } from './soundObjects/sch-rev-3.js'
import { schroederV2 } from './soundObjects/sch-rev-2.js'
import { schroederV1 } from './soundObjects/sch-rev-1.js'
import { loadSampleSound } from './soundObjects/loadSampleSound.js'
import { modulator } from './soundObjects/modulator.js'
import { flanger } from './soundObjects/flanger.js'








// let getSongs = () => {
//     const ms = Math.random() * 3000;
//     return of(songs).pipe(delay(ms));
// }

// let getGuitarPlayerById = (id) => {
//     const ms = Math.random() * 3000;
//     return of(guitarPlayer).pipe(
//         map((data) => data.find(gui => gui.id === id)),
//         delay(ms));
// }

// getSongs().pipe(
//     mergeMap(
//         songs =>
//             combineLatest(
//                 songs
//                     .map(song =>
//                         getGuitarPlayerById(song.owner)
//                             .pipe(
//                                 map(guitarrist => ({ ...song, guitarrist }))
//                             )
//                     )
//             )
//     )
// ).subscribe((songs) => {
//     console.log(songs);
// });





// const audio = new Audio('./out-the-door.mpeg');
// console.log(audio.buffered)

let context;
let audioController = null;
let audioL
let audioR
let buffer

window.addEventListener('load', init, false);

function init() {
    try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        context = new AudioContext();
        loadSampleSound('./assets/voz.wav', context).then((data) => {
            audioL = data.audioDataL;
            audioR = data.audioDataR;
            buffer = data.buffer;
            audioController = AudioController(buffer, context);
            effectOrder();
        })
    }
    catch (e) {
        alert('Web Audio API is not supported in this browser');
    }
}


document.getElementById('reverb-btn').addEventListener('click',
    () => {
        loading(true)
        setTimeout(
            () => {
                schroederV1(audioL).then(({ left, right }) => {
                    buffer.copyToChannel(left, 0);
                    buffer.copyToChannel(right, 1);
                    audioController = AudioController(buffer, context);
                    effectOrder('Reverb');
                    loading(false)
                })
            }, 0
        )
    });

document.getElementById('modulation-btn').addEventListener('click',
    () => {
        loading(true)
        setTimeout(
            () => {
                const L = modulator(audioL);
                const R = modulator(audioR);
                buffer.copyToChannel(L, 0);
                buffer.copyToChannel(R, 1);
                audioController = AudioController(buffer, context);
                effectOrder('Modulation');
                loading(false)
            }, 0
        )
    });

document.getElementById('flanger-btn').addEventListener('click',
    () => {
        loading(true)
        setTimeout(
            () => {
                const L = flanger(audioL,5,100);
                const R = flanger(audioR,5,100);
                buffer.copyToChannel(L, 0);
                buffer.copyToChannel(R, 1);
                audioController = AudioController(buffer, context);
                effectOrder('Flanger');
                loading(false)
            }, 0
        )
    });



document.getElementById('pause-btn').addEventListener('click', () => audioController ? audioController.stop() : alert('Efecto no seleccionado'));
document.getElementById('play-btn').addEventListener('click', () => audioController ? audioController.play() : alert('Efecto no seleccionado'));
document.getElementById('reset-btn').addEventListener('click', init);


//interactions-------------------------------------------------------------
function effectOrder(effect) {
    const el = document.querySelector('.effect-order');
    if (!el) return
    if (effect) {
        const li = document.createElement('li');
        li.innerHTML = effect;
        el.appendChild(li);
    } else {
        el.innerHTML = ''
    }
}

function loading(status) {
    const el = document.querySelector('.loading');
    el.style.display = status ? 'unset' : '';
}
