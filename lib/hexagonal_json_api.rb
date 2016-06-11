require 'rails'

require "hexagonal_json_api/version"

# directories_to_load = [
#   'hexagonal_json_api/presenters',
#   'hexagonal_json_api/responses',
#   'hexagonal_json_api/services',
# ]
#
# directories_to_load.each do |directory_path|
#   Dir[File.join(directory_path, '**/*.rb')].each { |file_path| require file_path }
# end

require 'hexagonal_json_api/presenters/base'
require 'hexagonal_json_api/presenters/null_presenter'

require 'hexagonal_json_api/services/base'

require 'hexagonal_json_api/responses/base'
require 'hexagonal_json_api/responses/create'

require 'hexagonal_json_api/service_command_executor'

module HexagonalJsonApi
  # Your code goes here...
end
