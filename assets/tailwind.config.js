module.exports = {
  content: [
    "./**/*.js",
    "../lib/**/*.ex",
    "../lib/**/*.html.heex",
  ],
  theme: {
    extend: {
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
