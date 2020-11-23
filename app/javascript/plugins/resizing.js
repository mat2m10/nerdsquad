let el = document.querySelectorAll(".piece");

const incsize = () => {
    el.forEach((i) => {
        let theheight = i.height;
        let newHeight = theheight/100 + 1;
        i.style.transform = `scale(${newHeight})`;
    })
}
const decsize = () => {
    el.forEach((i) => {
        let theheight = i.height;
        let newHeight = theheight/100 - 1;
        i.style.transform = `scale(${newHeight})`;
    })
}

export {incsize, decsize}
