import { sinWave } from './sin-wave.js'
import { FracDelay } from './fracDelay.js'
import { normalize } from './normalize.js'
export function modulator(audio, filter = 'Linear') {
    const F = new FracDelay(0, filter);
    const m = sinWave(audio.length, {});

    return normalize(
        audio.map((sample, index) => {
            F.setDelay(m[index])
            return F.process(sample)
        })
    )
}