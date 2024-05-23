module.exports = {
  content: [
    "./**/*.js",
    "../lib/**/*.ex",
    "../lib/**/*.html.heex",
  ],
  theme: {
    extend: {
      gridTemplateColumns: {
        'auto-fit-300': 'repeat(auto-fit, minmax(300px, 3fr))',
        'auto-fit-400': 'repeat(auto-fit, minmax(400px, 3fr))',
        'auto-fit-500': 'repeat(auto-fit, minmax(500px, 3fr))',
        'auto-fit-600': 'repeat(auto-fit, minmax(600px, 3fr))',
      },
      fontFamily: {
        'mono': ['Source Code Pro'],
        'sans': ['Anaheim'],
        'serif': ['Sumana-Regular'],
      }
    }
  },
  plugins: [
    require("@tailwindcss/typography"),
  ]
};
