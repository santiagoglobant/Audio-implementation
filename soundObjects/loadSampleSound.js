export function loadSampleSound(url, context) {
    // Decode asynchronously
    return new Promise(
        (resolve, reject) => {
            var request = new XMLHttpRequest();
            request.open('GET', url, true);
            request.responseType = 'arraybuffer';

            request.onload = function () {
                context.decodeAudioData(request.response,
                    function (buffer) {
                        // var anotherArray = new Float32Array(buffer.length);
                        
                        let audioDataL = buffer.getChannelData(0);
                        let audioDataR = buffer.getChannelData(1);

                        resolve({
                            audioDataL,
                            audioDataR,
                            buffer
                        })
                    }, (err) => {
                        reject(err)
                    });
            }
            request.send();
        }
    )
}
