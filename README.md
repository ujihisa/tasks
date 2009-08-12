# Tasks -- Better Process Manager for Ruby

## spawn

`tasks` provides `spawn` even in ruby 1.8.

    require 'tasks'
    include Tasks

    pid = spawn './something.rb'
    ...
    system "kill #{pid}"

`spawn` is like system with `'&'` and it also returns the procces id.

## love_pact

`tasks` supports a couple to do a love pact.

    require 'tasks'
    include Tasks

    master_pid = spawn './master.rb'
    slave_pid = spawn './slave.rb'

    fork do
      love_pact master_pid, slave_pid
    end

If a master died, the slave dies immediately.

Note that now `love_pact` works only in UNIX.
