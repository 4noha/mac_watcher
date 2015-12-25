class ArpWatchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    self.refresh_arp_table
    arp_table = `arp -a`
    @ips={}
    arp_table.split(" ").each do |e|
      ip_phrase = e.split(/^\(|\)$/)
      @ip = ip_phrase[1] if 2 == ip_phrase.count
      if 0 == (/^(([a-f]|[0-9]){2}:){5}([a-f]|[0-9]){2}$/ =~ e)
        @ips[@ip] = e
      end
    end
    
    # todo DISTINCTでNamedList内のクライアントの最新IN/OUT履歴を見る
    # todo 前回のリストからのIN/OUTの記録
    self.refresh_current_address_list
    
    ArpWatchJob.set(wait: 1.minutes).perform_later
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
