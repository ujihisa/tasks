module Tasks
  module_function

  def spawn(*cmd)
    fork { exec(*cmd) }
  end

  def love_pact(master, slave, interval = 2)
    loop {
      Process.kill 0, master
      sleep interval
    }
  rescue Errno::ESRCH
    Process.kill "KILL", slave
  end
end
