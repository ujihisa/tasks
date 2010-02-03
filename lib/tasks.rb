module Tasks
  module_function

  # Tasks.spawn
  # spawns a new process.
  #
  # This code is almost equivalent to the following code:
  #
  #     def spawn(*cmd)
  #       fork { exec(*cmd) }
  #     end
  #
  # But Tasks.spawn doesn't use exec() for avoiding making new process.
  #
  # e.g. spawn('sleep 100 | echo') generates the following two processes:
  # * sh -c 'sleep 100 | echo'
  # * sleep 10
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
    loop {
      Process.kill 0, master
      sleep interval
    }
  rescue Errno::ESRCH
    Process.kill "KILL", slave
  end

  # Kills a process's all children
  #     require 'lib/tasks'; include Tasks
  #     pid = spawn 'sleep 10 | head'
  #     kill_children(pid)
  #
  #     system 'ps aux | grep slee'
  def kill_children(parent_pid)
    a = `ps ax -o pid,command,ppid`.split(/\n/)[1..-1]
    pss = a.map {|i| i.strip.split(/\s+/, 3) }.select {|i| i[1].to_i == parent_pid }.map {|i| i[0] }
    pss.each {|i|
      begin
        Process.kill 'KILL', i.to_i
      rescue Errno::ESRCH => e
      end
    }
  end
end
