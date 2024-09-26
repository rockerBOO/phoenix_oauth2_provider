import Config

if Mix.env() == :test do
  import_config "#{config_env()}.exs"
end
