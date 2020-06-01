import { Filter } from './filter.js'
export async function schroederV2(audio) {
    const AP1 = new Filter(125, 0.7, 'All Pass');
    const AP2 = new Filter(42, 0.7, 'All Pass');
    const AP3 = new Filter(12, 0.7, 'All Pass');
    const FB1 = new Filter(901, 0.805, 'Feedback');
    const FB2 = new Filter(778, 0.827, 'Feedback');
    const FB3 = new Filter(1011, 0.783, 'Feedback');
    const FB4 = new Filter(1123, 0.764, 'Feedback');


    const yA = audio.map(sample =>
        AP3.process(
            AP2.process(
                AP1.process(
                    FB1.process(sample) +
                    FB2.process(sample) +
                    FB3.process(sample) +
                    FB4.process(sample)
                )
            )
        )
    )

    const valMax = yA.map(val => Math.abs(val)).reduce((curr, obj) => curr > obj ? curr : obj, 0)
    return yA.map(val => (val / valMax));
}