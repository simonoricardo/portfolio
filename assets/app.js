const controlNavbar = () => {
  if (typeof window !== 'undefined') {
    const nav = document.querySelector('nav')
    const navHeight = nav.getBoundingClientRect().height
    const classes = "sticky top-0 z-50 shadow-md shadow-zinc-400/60 bg-zinc-600 text-zinc-200".split(' ')
    const name = document.getElementById("name")
    
    if(window.scrollY > navHeight) {
      nav.classList.add(...classes)
      name.classList.add("text-zinc-200")
      name.classList.remove("text-zinc-700")
    } else {
      nav.classList.remove(...classes)
      name.classList.remove("text-zinc-200")
      name.classList.add("text-zinc-700")
    }
    
  }
};
controlNavbar();

window.addEventListener('scroll', controlNavbar);
