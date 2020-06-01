import { cosWave } from './sin-wave.js'
import { FracDelay } from './fracDelay.js'
import { normalize } from './normalize.js'

export function flanger(audio, fm = 5, factor = 500) {
    const d = new FracDelay(0, 'AllPass');
    const n = cosWave(audio.length, { ratio: factor * 0.5, fm });

    return normalize(audio.map((sample, index) => {
        d.setDelay(n[index])
        return sample + d.process(sample) * 0.75
    }));
}