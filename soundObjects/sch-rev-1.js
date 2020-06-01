import { Filter } from './filter.js'
import { normalize } from './normalize.js'


export async function schroederV1(audio) {
    const AP1 = new Filter(347, 0.7, 'All Pass');
    const AP2 = new Filter(113, 0.7, 'All Pass');
    const AP3 = new Filter(37, 0.7, 'All Pass');
    const FB1 = new Filter(1687, 0.773, 'Feedback');
    const FB2 = new Filter(1601, 0.802, 'Feedback');
    const FB3 = new Filter(2053, 0.753, 'Feedback');
    const FB4 = new Filter(2251, 0.733, 'Feedback');

    const data = Array.from(audio).map(sample => {
        const yAP3 = AP3.process(AP2.process(AP1.process(sample)));
        const yFB1 = FB1.process(yAP3);
        const yFB2 = FB2.process(yAP3);
        const yFB3 = FB3.process(yAP3);
        const yFB4 = FB4.process(yAP3);
        return {
            left: yFB1 + yFB2 + yFB3 + yFB4,
            right: yFB1 - yFB2 + yFB3 - yFB4
        }
    })
    return {
        left: normalize(data.map(audio => audio.left)),
        right: normalize(data.map(audio => audio.right)),
    }
}