
const incsize = (e) => {
    e.preventDefault()
    let el = document.querySelectorAll(".piece");
    el.forEach((i) => {
        let theheight = i.height;
        let newHeight = theheight/100 + 1;
        i.style.transform = `scale(${newHeight})`;
    })
}
const decsize = (e) => {
    e.preventDefault()
    let el = document.querySelectorAll(".piece");
    el.forEach((i) => {
        let theheight = i.height;
        let newHeight = theheight/100 - 1;
        i.style.transform = `scale(${newHeight})`;
    })
}

export {incsize, decsize}
