class ArpWatchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    arp_table = `arp -a`
    @ips={}
    arp_table.split(" ").each do |e|
      ip_phrase = e.split(/^\(|\)$/)
      @ip = ip_phrase[1] if 2 == ip_phrase.count
      if 0 == (/^(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}$/ =~ e)
        @ips[@ip] = e
      end
    end
    CurrentMacs.delete_all
    @ips.each_with_index do |(k, v), i|
      CurrentMacs.create do |m|
        m.id = i+1
        m.ip_address = k
        m.mac_address = v
      end
    end
    ArpWatchJob.set(wait: 1.minutes).perform_later
  end
end
