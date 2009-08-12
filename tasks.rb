module Tasks
  module_function

  def spawn(cmd)
    a = IO.popen(cmd)
    fork do
      while b = a.gets
        puts b
      end
    end
    a.pid
  end

  def love_pact(master, slave, interval = 2)
    loop do
      pss = `ps aux`.split(/\n/).map {|i| i.split }
      if pss.select {|ps| ps[1] == master }.empty?
        system "kill -KILL #{slave}"
        return
      end
      sleep interval
    end
  end
end
