namespace :rubocop do
  desc 'generate html rubocop report'
  task :report do
    `rubocop -D --format html -o rubocop.html`
    `chromium rubocop.html`
  end
end
