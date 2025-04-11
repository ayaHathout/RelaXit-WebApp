AOS.init({
    duration: 1000,
    offset: 120,
    easing: 'ease-in-out'
})

document.querySelectorAll('.cat-parent > a').forEach(item => {
    item.addEventListener('click', function(e) {
        e.preventDefault();
        const parentLi = this.parentElement;
        parentLi.classList.toggle('active');
    });
});