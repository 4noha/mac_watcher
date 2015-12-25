class ArpWatchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    self.refresh_arp_table
    arp_table = `arp -a`
    @ips = self.scan_address_list
    
    # todo DISTINCTでNamedList内のクライアントの最新IN/OUT履歴を見る
    # todo 前回のリストからのIN/OUTの記録
    self.refresh_current_address_list
    
    ArpWatchJob.set(wait: 1.minutes).perform_later
  end
  
  def scan_address_list
    arp_table = `arp -a`
    ips={}
    ip_phrase = []
    arp_table.split(" ").each do |e|
      ip_phrase = e.split(/^\(|\)$/) if 0 == (e =~ /^\((([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\)$/)
      ip = ip_phrase[1] if 2 == ip_phrase.count
      if 0 == (e =~ /^(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}$/)
        ips[ip] = e
      end
    end
    ips
  end
  
  def refresh_current_address_list
    CurrentMacs.delete_all
    @ips.each_with_index do |(k, v), i|
      CurrentMacs.create do |m|
        m.id = i+1
        m.ip_address = k
        m.mac_address = v
        named_client = NamedList.where(["ip_address = ? OR mac_address = ?", k, v]).first
        m.name = named_client.name if named_client.present?
      end
    end
  end
  
  # 自分のそれっぽいIPアドレスの1-255にnmapしてarpテーブルを更新する
  def refresh_arp_table
    udp = UDPSocket.new
    udp.connect("128.0.0.0", 7)
    adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
    udp.close
    `nmap -sP #{adrs.split(/([0-9])*$/).first}1-255 2> /dev/null`
  end
end
