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
  this.submitButton.value = "Sending ..."
  this.submitButton.disabled = true
  // these IDs from the previous steps
  emailjs.sendForm('service_qfwjxll', 'template_sek93ob', this)
    .then(() => {
      this.submitButton.value = "Success! Email sent!"
      this.submitButton.classList.remove("disabled:bg-zinc-300")
      this.submitButton.classList.add("bg-green-300")
    }, (error) => {
      this.submitButton.value = `Error...${error.text}`
      this.submitButton.classList.remove("disabled:bg-zinc-300")
      this.submitButton.classList.add("bg-red-300")
    });
});

document.getElementById('reset_button').addEventListener('click', function(event) {
  const form = document.getElementById('contact-form')
  console.log(form)
  form.reset()
})
