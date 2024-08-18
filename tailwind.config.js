module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './config/initializers/simple_form_tailwind.rb',
  ],
  plugins: [
    require('daisyui'),
  ],
}
