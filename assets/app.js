(function() {
  emailjs.init({
    publicKey: "6WlbUWZuRW4QDwNBv",
  });
})();

let activeElement = null;

const applyClasses = (sectionTitle, navElement) => {
  const classes = "bg-zinc-700 text-stone-50 rounded-md rotate-6 scale-110".split(' ');

  if (sectionTitle.isIntersecting && sectionTitle.intersectionRatio >= 0.6) {
    if (activeElement) {
      activeElement.classList.remove(...classes)
    }

    activeElement = navElement
    activeElement.classList.add(...classes)
  }
}


const io = new IntersectionObserver((sections) => {
  sections.forEach((sections) => {
    switch (sections.target.id) {
      case "about":
        applyClasses(sections, document.querySelector("#about-nav"));
        break;

      case "photos":
        applyClasses(sections, document.querySelector("#photos-nav"));
        break;

      case "posts":
        applyClasses(sections, document.querySelector("#posts-nav"));
        break;

      case "contact":
        applyClasses(sections, document.querySelector("#contact-nav"));
        break;
    }
  });
}, { rootMargin: "100px 0px 0px 0px", threshold: 0.8 });

const elements = document.querySelectorAll('section');

elements.forEach((el) => {
  io.observe(el);
});


const ACTIVE_CLASSES = "sticky top-0 z-50".split(' ')

const controlNavbar = () => {
  if (typeof window !== 'undefined') {
    const nav = document.querySelector('nav')
    const navHeight = nav.getBoundingClientRect().height

    if (window.scrollY > navHeight) {
      nav.classList.add(...ACTIVE_CLASSES)
    } else {
      nav.classList.remove(...ACTIVE_CLASSES)
    }

  }
};
controlNavbar();

window.addEventListener('scroll', controlNavbar);

const lightbox = GLightbox({
  touchNavigation: true,
  loop: true,
  autoplayVideos: true,
  width: "90vw",
  height: "90vh"
});

document.getElementById('contact-form').addEventListener('submit', function(event) {
  event.preventDefault();
  const response = grecaptcha.getResponse();
  if (response.length === 0) return;

  this.submit_button.innerText = "Sending ..."
  this.submit_button.classList.add("disabled:bg-zinc-300")
  this.submit_button.classList.remove("bg-red-300")
  this.submit_button.disabled = true
  emailjs.sendForm('service_qfwjxll', 'template_sek93ob', this)
    .then(() => {
      this.submit_button.innerText = "👍🏻Success! Email sent!"
      this.submit_button.classList.remove("disabled:bg-zinc-300", "bg-white", "bg-red-300")
      this.submit_button.classList.add("bg-green-400")
    }, (error) => {
      this.submit_button.innerText = "Error! Please try again"
      this.submit_button.classList.remove("disabled:bg-zinc-300", "bg-white")
      this.submit_button.classList.add("bg-red-300")
      this.submit_button.disabled = false
      grecaptcha.reset()
    });
});

document.getElementById('reset_button').addEventListener('click', function(event) {
  const form = document.getElementById('contact-form')
  form.submit_button.innerText = "⚡ Send"
  form.submit_button.disabled = true
  form.submit_button.classList.add("disabled:bg-zinc-300", "bg-white")
  form.submit_button.classList.remove("bg-red-300", "bg-green-400")
  grecaptcha.reset()
  form.reset()
})
