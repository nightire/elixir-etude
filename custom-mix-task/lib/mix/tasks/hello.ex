defmodule Mix.Tasks.Hello do
  use Mix.Task

  @shortdoc "执行 Etude.greet 命令"
  def run(_) do
    Etude.greet
  end
end
