/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: "#5a5278",
          100: "#a192d9",
          400: "#474262",
        },
      },
    },
  },
  plugins: [],
};
