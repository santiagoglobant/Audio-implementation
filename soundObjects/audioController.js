var VolumeSample = {
    buffer: null,
    context:null
};

// Gain node needs to be mutated by volume control.
VolumeSample.gainNode = null;
VolumeSample.buffer = null;
VolumeSample.context = null;


VolumeSample.play = function () {
    if (!this.context.createGain)
        this.context.createGain = this.context.createGainNode;
    this.gainNode = this.context.createGain();
    var source = this.context.createBufferSource();
    source.buffer = this.buffer;

    // Connect source to a gain node
    source.connect(this.gainNode);
    // Connect gain node to destination
    this.gainNode.connect(this.context.destination);
    // Start playback in a loop
    source.loop = false;
    if (!source.start)
        source.start = source.noteOn;
    source.start(0);
    this.source = source;
};

VolumeSample.changeVolume = function (element) {
    var volume = element.value;
    var fraction = parseInt(element.value) / parseInt(element.max);
    // Let's use an x*x curve (x-squared) since simple linear (x) does not
    // sound as good.
    this.gainNode.gain.value = fraction * fraction;
};

VolumeSample.stop = function () {
    if (!this.source.stop)
        this.source.stop = source.noteOff;
    this.source.stop(0);
};

VolumeSample.toggle = function () {
    this.playing ? this.stop() : this.play();
    this.playing = !this.playing;
}

export const AudioController = function (buffer,context) {
    VolumeSample.buffer = buffer;
    VolumeSample.context = context;

    return VolumeSample;
}