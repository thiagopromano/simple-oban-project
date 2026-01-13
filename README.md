This is a simple project with the minimum necessary to run Oban. The main idea is to use it for proving any bugs that are found in the library.

To run it:
- Start EPMD with `epmd -daemon`
- Run `mix ecto.create` and `mix ecto.migrate`
- Start the workers with `iex --sname node1 -S mix run --no-halt`
- Start "web" without queues with `iex --sname web1 -S mix run --no-halt`
- Verify that the heartbeat is working by checking the logs of the worker nodes.