

Capybara.register_driver :local_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1400,700")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :local_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end


Capybara.register_driver :remote_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1400,700")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--remote-debugging-port=9222")

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://#{SELENIUM_HOST}:4444/wd/hub",
    options: options,
  )
end

Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--remote-debugging-port=9222")

  Capybara::Selenium::Driver.new(app, {
    browser: :remote,
    url: "http://#{SELENIUM_HOST}:4444/wd/hub",
    options: options,
  })
end

Capybara.register_driver :remote_headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--remote-debugging-port=9222")

  Capybara::Selenium::Driver.new(app, {
    browser: :firefox,
    url: "http://#{SELENIUM_HOST}:4444/wd/hub",
    options: options,
  })
end