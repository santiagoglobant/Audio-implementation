export function Filter(m, g, t) {
    this.order = m;
    this.gain = g;
    this.type = t;
    this.buffer = Array.from({ length: this.order }, () => 0);

    switch (t) {
        case 'Delay Line':
            this.num = [0, ...new Float32Array(m), g];
            this.den = [1, ...new Float32Array(m), 0];
            break;
        case 'Feedforward':
            this.num = [1, ...new Float32Array(m), g];
            this.den = [1, ...new Float32Array(m), 0];
            break;
        case 'Feedback':
            this.num = [1, ...new Float32Array(m), 0];
            this.den = [1, ...new Float32Array(m), -g];
            break;
        case 'All Pass':
            this.num = [-g, ...new Float32Array(m), 1];
            this.den = [1, ...new Float32Array(m), -g];
            break;
    }

    this.process = function (frame) {
        const out = (this.num[0] * frame + this.buffer[this.order - 1]) / this.den[0];
        this.buffer.splice(0, 0, this.num[this.order+1] * frame - this.den[this.order+1] * out);
        this.buffer.pop();
        return out;
    };

}
