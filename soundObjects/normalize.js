import { valMax } from './valMax.js'
export function normalize(data) {
    const max = valMax(data)
    return new Float32Array(data.map(val => val / max))
}