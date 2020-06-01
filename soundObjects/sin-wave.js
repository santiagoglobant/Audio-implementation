export function sinWave(length, { fs = 44100, ratio = 1000, fm = 1 }) {
    return Array.from({ length }, (val, index) => ratio + ratio * Math.sin(2 * Math.PI * fm * index / fs));
}

export function cosWave(length, { fs = 44100, ratio = 1000, fm = 1 }) {
    return Array.from({ length }, (val, index) => ratio + ratio * Math.cos(2 * Math.PI * fm * index / fs));
}
