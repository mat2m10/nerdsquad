
const incsize = () => {
    let el = document.querySelectorAll(".piece");
    el.forEach((i) => {
        let height = i.getAttribute("height")
        console.log(height)
        let heightNumber = height.substr(0, height.indexOf('p'))
        let integer = parseInt(heightNumber, 10)
        console.log(integer)
        console.log(i.getAttribute("height"))
        i.setAttribute("height", i.getAttribute("height") + 200 + 'px' );
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
