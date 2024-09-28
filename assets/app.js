(function() {
  emailjs.init({
    publicKey: "6WlbUWZuRW4QDwNBv",
  });
})();

let activeElement = null;

const applyClasses = (section, navElement) => {
  const navClasses = "bg-zinc-700 text-stone-50 rounded-md rotate-6 scale-110".split(' ');

  if (section.isIntersecting && section.intersectionRatio >= 0.6) {
    if (activeElement) {
      activeElement.classList.remove(...navClasses)
    }

    activeElement = navElement
    activeElement.classList.add(...navClasses)
  }
}


const io = new IntersectionObserver((sections) => {
  sections.forEach((section) => {
    switch (section.target.id) {
      case "about":
        applyClasses(section, document.querySelector("#about-nav"));
        break;

      case "photos":
        applyClasses(section, document.querySelector("#photos-nav"));
        break;

      case "posts":
        applyClasses(section, document.querySelector("#posts-nav"));
        break;

      case "contact":
        applyClasses(section, document.querySelector("#contact-nav"));
        break;
    }
  });
}, { rootMargin: "100px 0px 0px 0px", threshold: 0.8 });

const elements = document.querySelectorAll('section');

elements.forEach((el) => {
  io.observe(el);
});

document.querySelector('main').addEventListener('scroll', fadeIn); 
function fadeIn() {
  elements.forEach((el) => {
    const dist = el.getBoundingClientRect().top - window.innerHeight + 20;

    if (dist < -100) {
        el.classList.add("fade-in");
    } else {
        el.classList.remove("fade-in");
    }

  }); 
}

fadeIn();


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
