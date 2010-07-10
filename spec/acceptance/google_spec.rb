require 'spec_helper'

feature "Main page" do
  scenario "visting google" do
    browser = Selenium::WebDriver.for :firefox
    browser.navigate.to("http://www.google.com")
    browser.page_source.should match(/google/)
    browser.close
  end
end