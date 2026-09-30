#!/usr/bin/env ruby
# frozen_string_literal: true

# Scrape per-user token usage from the RCC AI gateway dashboard.
#
# The dashboard renders one row per model for a given user and date. This
# script discovers the available users from the dashboard's user picker, then
# walks the last DAYS days for each user and writes one JSON object per row to
# ~/.rcctoken/json/<user>-<date>.json

require 'date'
require 'fileutils'
require 'json'
require 'net/http'
require 'nokogiri'
require 'uri'

BASE_URL = 'https://rcc-ai-gateway-dashboard.api.rccchina.com/dashboard/usage-by-user'
DAYS = (ARGV[0] || 7).to_i
NO_RECORD_TEXT = '没有使用记录'
UNKNOWN_USER_TEXT = '用户不存在'
RETRIES = 3
OPEN_TIMEOUT = 15
READ_TIMEOUT = 60

ROOT_DIR = File.expand_path('~/.rcctoken')
HTML_DIR = File.join(ROOT_DIR, 'html')
JSON_DIR = File.join(ROOT_DIR, 'json')

# Fetch a dashboard page as UTF-8 text, retrying a few times on failure.
def fetch_page(query)
  uri = URI(BASE_URL)
  uri.query = URI.encode_www_form(query)

  RETRIES.times do |attempt|
    begin
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https',
                                 open_timeout: OPEN_TIMEOUT, read_timeout: READ_TIMEOUT) do |http|
        http.get(uri.request_uri)
      end

      return response.body.force_encoding(Encoding::UTF_8) if response.is_a?(Net::HTTPSuccess)

      warn "HTTP #{response.code} for #{uri}"
    rescue StandardError => e
      warn "#{e.class}: #{e.message} for #{uri}"
    end

    sleep 1 if attempt < RETRIES - 1
  end

  nil
end

# The user picker lists every known user as <option value="user_NNN">.
def fetch_user_ids(ymd)
  html = fetch_page(start_date: ymd, end_date: ymd)
  return [] if html.nil?

  Nokogiri::HTML(html)
          .css('select option[value^="user_"]')
          .filter_map { |option| option['value'][/\Auser_(\d+)\z/, 1] }
          .uniq
          .sort
end

# Pull the columns we care about out of the usage table.
def extract_rows(html, user_id, ymd)
  doc = Nokogiri::HTML(html)

  doc.css('tbody tr').filter_map do |tr|
    cells = tr.css('td').map { |td| td.text.strip }
    next if cells.empty?

    {
      model: cells[1],
      fee: cells[12],
      request: cells[6]&.delete(','),
      token: cells[5]&.delete(','),
      user: user_id,
      date: ymd
    }
  end
end

# Top-level return so the file can be loaded for testing without side effects.
return unless __FILE__ == $PROGRAM_NAME

FileUtils.mkdir_p([HTML_DIR, JSON_DIR])

today = Date.today
today_ymd = today.strftime('%F')

user_ids = fetch_user_ids(today_ymd)
if user_ids.empty?
  warn 'No users found in the dashboard user picker; aborting.'
  exit 1
end

DAYS.times do |d|
  user_ids.each do |user_id|
    ymd = (today - (DAYS - d)).strftime('%F')
    html_path = File.join(HTML_DIR, "#{ymd}-#{user_id}.html")
    json_path = File.join(JSON_DIR, "#{ymd}-#{user_id}.json")

    html = fetch_page(user_id: "user_#{user_id}", start_date: ymd, end_date: ymd)
    if html.nil?
      warn "#{user_id} #{ymd}: request failed, skipping"
      next
    end

    File.write(html_path, html)

    if html.include?(NO_RECORD_TEXT) || html.include?(UNKNOWN_USER_TEXT)
      FileUtils.rm_f(html_path)
      next
    end

    rows = extract_rows(html, user_id, ymd)
    File.open(json_path, 'w') do |file|
      rows.each { |row| file.puts(JSON.generate(row)) }
    end
  end
end
