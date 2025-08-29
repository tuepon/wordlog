/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/stylesheets/pagy.tailwind.css",
  ],
  safelist: [
    "flex",
    "space-x-1",
    "font-semibold",
    "text-sm",
    "text-gray-500",
    "hover:underline",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
