require 'api/apple_music'
require 'api/deezer'

require 'erb'

class JumpApp
  def self.call(env)
    orig_url = env['streamflow.incoming_url'].to_s
    provider = env['streamflow.provider_entity'].first
    id       = env['streamflow.provider_entity'].last

    entity_data = Object.const_get("Api::#{provider}").find(id)

    path = File.expand_path("../../views/jump.erb", __FILE__)
    view = ERB.new(File.read(path)).result(binding)

    [200, {'Content-Type' => 'text/html'}, [view]]
  end
end
