(function() {
  emailjs.init({
    publicKey: "6WlbUWZuRW4QDwNBv",
  });
})();

const controlNavbar = () => {
  if (typeof window !== 'undefined') {
    const nav = document.querySelector('nav')
    const navHeight = nav.getBoundingClientRect().height
    const classes = "sticky top-0 z-50 shadow-md shadow-zinc-400/60 bg-zinc-600 text-zinc-200".split(' ')
    const name = document.getElementById("name")

    if (window.scrollY > navHeight) {
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

  this.submitButton.value = "Sending ..."
  this.submitButton.classList.add("disabled:bg-zinc-300")
  this.submitButton.classList.remove("bg-red-300")
  this.submitButton.disabled = true
  emailjs.sendForm('service_qfwjxll', 'template_sek93ob', this)
    .then(() => {
      this.submitButton.value = "Success! Email sent!"
      this.submitButton.classList.remove("disabled:bg-zinc-300", "bg-white", "bg-red-300")
      this.submitButton.classList.add("bg-green-400")
    }, (error) => {
      this.submitButton.value = "Error! Please try again"
      this.submitButton.classList.remove("disabled:bg-zinc-300", "bg-white")
      this.submitButton.classList.add("bg-red-300")
      this.submitButton.disabled = false
      grecaptcha.reset()
    });
});

document.getElementById('reset_button').addEventListener('click', function(event) {
  const form = document.getElementById('contact-form')
  form.submitButton.disabled = false
  form.submitButton.classList.add("disabled:bg-zinc-300", "bg-white")
  form.submitButton.classList.remove("bg-red-300", "bg-green-400")
  grecaptcha.reset()
  form.reset()
})
