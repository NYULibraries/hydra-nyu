Then(/^I should get to the "(.*?)" form$/) do |form|
   expect(page.find(:xpath, "//form[@id='#{form}_nyucore_sdr:DSS-ESRI_10_World-DSS-world30_WDQ']"))
end

Then(/^the search results should have link "(.*?)"$/) do |link|
  expect(documents_list_container).to have_link(link)
end

When(/^I click on the first "(.*?)" link$/) do |link_text|
    accept_javascript_confirms
    first(:link, link_text).click
end

When(/^I click on the "(.*?)" link$/) do |link_text|
    accept_javascript_confirms
    click_on(link_text)
end