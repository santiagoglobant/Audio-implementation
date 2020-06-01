export function FracDelay(M, i) {
    this.maxDelay = 44100;
    this.interpolation = i;
    this.lastOut = 0;
    this.M = M > this.maxDelay ? this.maxDelay : M
    this.buffer = new Float32Array(this.maxDelay);
    this.pW = this.maxDelay;
    this.pR = this.pW - Math.floor(this.M);

    this.process = function (frame) {
        const wI = (this.pW % this.maxDelay) + 1;
        const rI = (this.pR % this.maxDelay) + 1;
        const rI2 = ((this.pR - 1) % this.maxDelay) + 1;
        const frac = this.M - Math.floor(this.M);
        let out = 0;
        this.buffer[wI] = frame;
        switch (i) {
            case 'Linear':
                out = frac * this.buffer[rI2] + (1 - frac) * this.buffer[rI];
                break;
            case 'AllPass':
                out = this.buffer[rI2] + ((1 - frac) * (this.buffer[rI] - this.lastOut));
                this.lastOut = isNaN(out) ? 0 : out;
                break;
        }

        this.pW = this.pW + 1;
        this.pR = this.pR + 1;
        const a = [this.pW, this.pR]

        // if(isNaN(out))debugger
        return isNaN(out) ? 0 : out;
    };

    this.setDelay = function (M) {
        this.M = M > this.maxDelay ? this.maxDelay : M;
        this.pR = this.pW - Math.floor(this.M);
    }
}
