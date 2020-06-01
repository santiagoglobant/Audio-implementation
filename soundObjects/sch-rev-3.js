import { Filter } from './filter.js'
export async function schroederV3(audio) {
    const AP1 = new Filter(1051, 0.7, 'All Pass');
    const AP2 = new Filter(337, 0.7, 'All Pass');
    const AP3 = new Filter(113, 0.7, 'All Pass');
    const FB1 = new Filter(4799, 0.742, 'Feedforward');
    const FB2 = new Filter(4999, 0.733, 'Feedforward');
    const FB3 = new Filter(5399, 0.715, 'Feedforward');
    const FB4 = new Filter(5801, 0.697, 'Feedforward');

    const yA = Array.from(audio).map(sample => {
        const yAP3 = AP3.process(AP2.process(AP1.process(sample)));
        return FB1.process(yAP3) +
            FB2.process(yAP3) +
            FB3.process(yAP3) +
            FB4.process(yAP3);
    })

    const valMax = yA.map(val => Math.abs(val)).reduce((curr, obj) => curr > obj ? curr : obj, 0)
    return yA.map(val => (val / valMax));
}